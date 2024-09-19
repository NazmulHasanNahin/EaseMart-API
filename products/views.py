# products/views.py
from rest_framework import viewsets
from .models import Product, Cart
from rest_framework.permissions import AllowAny
from .serializers import ProductSerializer, CartSerializer
from rest_framework import generics, status, permissions
from rest_framework.response import Response
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework.filters import SearchFilter
from rest_framework.exceptions import PermissionDenied, NotFound, ValidationError
from rest_framework.decorators import api_view, permission_classes
from rest_framework.renderers import JSONRenderer
from rest_framework.views import APIView
from .serializers import PurchaseSerializer
from rest_framework.authentication import TokenAuthentication
from rest_framework.permissions import IsAuthenticated


class ProductViewSet(viewsets.ModelViewSet):
    queryset = Product.objects.all()
    serializer_class = ProductSerializer
    filter_backends = [SearchFilter, DjangoFilterBackend]
    search_fields = ['name']  

    filterset_fields = ['category__name']  

    def get_queryset(self):
        queryset = super().get_queryset()
        search_query = self.request.query_params.get('search')
        
        if search_query:
            queryset = queryset.filter(name__icontains=search_query)
        
        return queryset


class CartView(generics.ListCreateAPIView):
    serializer_class = CartSerializer
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        user = self.request.user
        if user.is_anonymous:
            raise PermissionDenied("You must be logged in to view cart items.")
        return Cart.objects.filter(user=user)

    def create(self, request, *args, **kwargs):
        user = request.user
        if user.is_anonymous:
            return Response({"detail": "Authentication credentials were not provided."}, status=status.HTTP_401_UNAUTHORIZED)

        product_id = request.data.get('product')
        quantity = request.data.get('quantity', 1)

        if not product_id:
            return Response({"detail": "Product ID is required."}, status=status.HTTP_400_BAD_REQUEST)

        try:
            product = Product.objects.get(id=product_id)
        except Product.DoesNotExist:
            return Response({"detail": "Product not found."}, status=status.HTTP_404_NOT_FOUND)

        cart_item, created = Cart.objects.get_or_create(
            user=user, product=product, defaults={'quantity': quantity})
        if not created:
            cart_item.quantity += quantity
            cart_item.save()
            return Response({"detail": "Product quantity updated in cart."}, status=status.HTTP_200_OK)

        return Response({"detail": "Product added to cart."}, status=status.HTTP_201_CREATED)

from django.shortcuts import get_object_or_404
from rest_framework.permissions import IsAuthenticated


class AddToCartView(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request, product_id, *args, **kwargs):
        quantity = request.data.get('quantity', 1) 
        
        user_account = getattr(request.user, 'useraccount', None)
        if not user_account:
            return Response({"error": "User does not have an associated UserAccount"}, status=status.HTTP_400_BAD_REQUEST)

        product = get_object_or_404(Product, id=product_id)

        # Add or update cart item
        cart_item, created = Cart.objects.get_or_create(
            user=user_account,
            product=product,
            defaults={'quantity': quantity}
        )

        if not created:
            cart_item.quantity += quantity
            cart_item.save()

        return Response({"message": "Product added to cart successfully!"}, status=status.HTTP_201_CREATED)



class RemoveFromCartView(generics.DestroyAPIView):
    permission_classes = [permissions.IsAuthenticated]

    def delete(self, request, *args, **kwargs):
        cart_item_id = self.kwargs.get('cart_item_id')
        
        user_account = getattr(request.user, 'useraccount', None)
        if not user_account:
            return Response({"error": "User does not have an associated UserAccount"}, status=status.HTTP_400_BAD_REQUEST)

        try:
            cart_item = Cart.objects.get(id=cart_item_id, user=user_account)  
        except Cart.DoesNotExist:
            raise ValidationError("Cart item not found.")
        
        if cart_item.quantity > 1:
            cart_item.quantity -= 1
            cart_item.save()
            return Response({"message": "Item quantity decreased by 1."}, status=status.HTTP_200_OK)
        else:
            cart_item.delete()
            return Response({"message": "Item removed from cart successfully!"}, status=status.HTTP_204_NO_CONTENT)
    
    
from .models import Cart, Purchase


class PurchaseView(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request):
        user_account = getattr(request.user, 'useraccount', None)
        if not user_account:
            return Response({"error": "User does not have an associated UserAccount"}, status=status.HTTP_400_BAD_REQUEST)

        # Fetch the user's cart items
        cart_items = Cart.objects.filter(user=user_account)

        if not cart_items.exists():
            return Response({"error": "Your cart is empty. Add items to your cart before purchasing."}, status=status.HTTP_400_BAD_REQUEST)

        # Process each cart item as a purchase
        purchases = []
        for cart_item in cart_items:
            purchase = Purchase.objects.create(
                customer=user_account,
                product=cart_item.product,
                quantity=cart_item.quantity
            )
            purchases.append(purchase)
        
        # Clear the user's cart after purchase
        cart_items.delete()

        return Response({"message": "Purchase successful!", "purchases": [str(purchase) for purchase in purchases]}, status=status.HTTP_201_CREATED)

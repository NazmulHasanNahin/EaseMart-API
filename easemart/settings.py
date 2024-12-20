from pathlib import Path
import os
import environ
env = environ.Env()
environ.Env.read_env()
# Build paths inside the project like this: BASE_DIR / 'subdir'.
BASE_DIR = Path(__file__).resolve().parent.parent


# Quick-start development settings - unsuitable for production
# See https://docs.djangoproject.com/en/5.0/howto/deployment/checklist/

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = 'django-insecure-5)xl$9m@$yrps4ps)#e!mjyew=1$yrlqrkqlrs!edmldpd=f3a'

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = True

ALLOWED_HOSTS = [
    "127.0.0.1",
    ".vercel.app",
    "easemart-api.onrender.com",
    "easemart.netlify.app",
]


# Application definition

INSTALLED_APPS = [
    "whitenoise.runserver_nostatic",
    'corsheaders',
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    # Third-party apps
    'rest_framework',
    'rest_framework.authtoken',  # For token-based authentication
    'dj_rest_auth',  # For user authentication
    'allauth',  # Required for registration
    'allauth.account',  # Required for registration
    'dj_rest_auth.registration',  # For registration
    'allauth.socialaccount',
    'django_filters',

    # my apps
    'users',  
    'products',
    'categories',
    'dashboard',
    
    
    
]


MIDDLEWARE = [
    "corsheaders.middleware.CorsMiddleware",
    "django.middleware.common.CommonMiddleware",
    'django.middleware.security.SecurityMiddleware',
    "whitenoise.middleware.WhiteNoiseMiddleware",
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'allauth.account.middleware.AccountMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
]

ROOT_URLCONF = 'easemart.urls'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': ["templates",],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]

WSGI_APPLICATION = 'easemart.wsgi.app'

MEDIA_URL = '/media/'
MEDIA_ROOT = os.path.join(BASE_DIR, 'media')

STATIC_ROOT= BASE_DIR / "staticfiles"

# settings.py
REST_FRAMEWORK = {
    'DEFAULT_AUTHENTICATION_CLASSES': [
        'rest_framework.authentication.TokenAuthentication',  # Token-based authentication
        'rest_framework.authentication.SessionAuthentication',  # Default session-based authentication
    ],
    'DEFAULT_FILTER_BACKENDS': ['django_filters.rest_framework.DjangoFilterBackend'],
    'DEFAULT_PERMISSION_CLASSES': [
        'rest_framework.permissions.AllowAny',  
    ],
    
}





# Database
# https://docs.djangoproject.com/en/5.0/ref/settings/#databases

# DATABASES = {
#     'default': {
#         'ENGINE': 'django.db.backends.sqlite3',
#         'NAME': BASE_DIR / 'db.sqlite3',
#     }
# }


DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'postgres',
        'USER': 'postgres.tnqdxkldhbwwrunpkzhe',
        'PASSWORD': 'N@h!n257312',
        'HOST': 'aws-0-ap-southeast-1.pooler.supabase.com',
        'PORT': '6543',
        'OPTIONS': {
            'connect_timeout': 30, 
        }
    }
}


SSLCOMMERZ = {
    'store_id': 'easem671e440d71709',
    'store_pass': 'easem671e440d71709@ssl',
    'sandbox': True  # Set to False in production
}



STRIPE_PUBLISHABLE_KEY = os.getenv("STRIPE_PUBLISHABLE_KEY", "pk_test_51QEvqcKLfSOq071FTArbOJ470pJalJ0yyJpwSP8xYWj16UjoJSMsedbdsd4XIZRibdjy5r1RGaiiWwJa2fFBoQVm00UGVPWasA")
STRIPE_SECRET_KEY = os.getenv("STRIPE_SECRET_KEY", "sk_test_51QEvqcKLfSOq071FiBukVqKG7OzLu1iwVjW2Nu7m77DoLqFfdQ3rn1mo7rwXs4Wrg07KLEnDSfCIYbDt801TpwWs00FxC6obcU")

# Password validation
# https://docs.djangoproject.com/en/5.0/ref/settings/#auth-password-validators

AUTH_PASSWORD_VALIDATORS = [
    {
        'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator',
    },
]


# Internationalization
# https://docs.djangoproject.com/en/5.0/topics/i18n/

LANGUAGE_CODE = 'en-us'

TIME_ZONE = 'UTC'

USE_I18N = True

USE_TZ = True


# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/5.0/howto/static-files/

STATIC_URL = 'static/'

# Default primary key field type
# https://docs.djangoproject.com/en/5.0/ref/settings/#default-auto-field

DEFAULT_AUTO_FIELD = 'django.db.models.BigAutoField'


CORS_ALLOWED_ORIGINS = [
    "http://127.0.0.1:7000","http://127.0.0.1:5501","https://easemart.netlify.app","https://ease-mart-api.vercel.app","https://easemart-api.onrender.com",
]

CSRF_TRUSTED_ORIGINS = ["http://127.0.0.1:5501","https://easemart.netlify.app","https://ease-mart-api.vercel.app","https://easemart-api.onrender.com",]

CORS_ALLOW_CREDENTIALS = True


EMAIL_BACKEND = 'django.core.mail.backends.smtp.EmailBackend'
EMAIL_HOST = 'smtp.gmail.com'
EMAIL_USE_TLS = True
EMAIL_PORT = 587
EMAIL_HOST_USER = env("EMAIL_HOST_USER")
EMAIL_HOST_PASSWORD = env("EMAIL_HOST_PASSWORD")
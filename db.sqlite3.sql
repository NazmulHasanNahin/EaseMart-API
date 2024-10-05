BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "django_migrations" (
	"id"	integer NOT NULL,
	"app"	varchar(255) NOT NULL,
	"name"	varchar(255) NOT NULL,
	"applied"	datetime NOT NULL,
	SERIAL PRIMARY KEY
);
CREATE TABLE IF NOT EXISTS "auth_group_permissions" (
	"id"	integer NOT NULL,
	"group_id"	integer NOT NULL,
	"permission_id"	integer NOT NULL,
	SERIAL PRIMARY KEY,
	FOREIGN KEY("permission_id") REFERENCES "auth_permission"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("group_id") REFERENCES "auth_group"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "auth_user_groups" (
	"id"	integer NOT NULL,
	"user_id"	integer NOT NULL,
	"group_id"	integer NOT NULL,
	SERIAL PRIMARY KEY,
	FOREIGN KEY("group_id") REFERENCES "auth_group"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "auth_user_user_permissions" (
	"id"	integer NOT NULL,
	"user_id"	integer NOT NULL,
	"permission_id"	integer NOT NULL,
	SERIAL PRIMARY KEY,
	FOREIGN KEY("permission_id") REFERENCES "auth_permission"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "account_emailconfirmation" (
	"id"	integer NOT NULL,
	"created"	datetime NOT NULL,
	"sent"	datetime,
	"key"	varchar(64) NOT NULL UNIQUE,
	"email_address_id"	integer NOT NULL,
	SERIAL PRIMARY KEY,
	FOREIGN KEY("email_address_id") REFERENCES "account_emailaddress"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "account_emailaddress" (
	"id"	integer NOT NULL,
	"verified"	bool NOT NULL,
	"primary"	bool NOT NULL,
	"user_id"	integer NOT NULL,
	"email"	varchar(254) NOT NULL,
	SERIAL PRIMARY KEY,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "django_admin_log" (
	"id"	integer NOT NULL,
	"object_id"	text,
	"object_repr"	varchar(200) NOT NULL,
	"action_flag"	smallint unsigned NOT NULL CHECK("action_flag" >= 0),
	"change_message"	text NOT NULL,
	"content_type_id"	integer,
	"user_id"	integer NOT NULL,
	"action_time"	datetime NOT NULL,
	SERIAL PRIMARY KEY,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "django_content_type" (
	"id"	integer NOT NULL,
	"app_label"	varchar(100) NOT NULL,
	"model"	varchar(100) NOT NULL,
	SERIAL PRIMARY KEY
);
CREATE TABLE IF NOT EXISTS "auth_permission" (
	"id"	integer NOT NULL,
	"content_type_id"	integer NOT NULL,
	"codename"	varchar(100) NOT NULL,
	"name"	varchar(255) NOT NULL,
	SERIAL PRIMARY KEY,
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "auth_group" (
	"id"	integer NOT NULL,
	"name"	varchar(150) NOT NULL UNIQUE,
	SERIAL PRIMARY KEY
);
CREATE TABLE IF NOT EXISTS "auth_user" (
	"id"	integer NOT NULL,
	"password"	varchar(128) NOT NULL,
	"last_login"	datetime,
	"is_superuser"	bool NOT NULL,
	"username"	varchar(150) NOT NULL UNIQUE,
	"last_name"	varchar(150) NOT NULL,
	"email"	varchar(254) NOT NULL,
	"is_staff"	bool NOT NULL,
	"is_active"	bool NOT NULL,
	"date_joined"	datetime NOT NULL,
	"first_name"	varchar(150) NOT NULL,
	SERIAL PRIMARY KEY
);
CREATE TABLE IF NOT EXISTS "authtoken_token" (
	"key"	varchar(40) NOT NULL,
	"created"	datetime NOT NULL,
	"user_id"	integer NOT NULL UNIQUE,
	PRIMARY KEY("key"),
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "categories_category" (
	"id"	integer NOT NULL,
	"name"	varchar(100) NOT NULL,
	"slug"	varchar(100) NOT NULL UNIQUE,
	SERIAL PRIMARY KEY
);
CREATE TABLE IF NOT EXISTS "dashboard_customerdashboard_recent_purchases" (
	"id"	integer NOT NULL,
	"customerdashboard_id"	bigint NOT NULL,
	"product_id"	bigint NOT NULL,
	SERIAL PRIMARY KEY,
	FOREIGN KEY("product_id") REFERENCES "products_product"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("customerdashboard_id") REFERENCES "dashboard_customerdashboard"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "django_session" (
	"session_key"	varchar(40) NOT NULL,
	"session_data"	text NOT NULL,
	"expire_date"	datetime NOT NULL,
	PRIMARY KEY("session_key")
);
CREATE TABLE IF NOT EXISTS "socialaccount_socialapp" (
	"id"	integer NOT NULL,
	"provider"	varchar(30) NOT NULL,
	"name"	varchar(40) NOT NULL,
	"client_id"	varchar(191) NOT NULL,
	"secret"	varchar(191) NOT NULL,
	"key"	varchar(191) NOT NULL,
	"provider_id"	varchar(200) NOT NULL,
	"settings"	text NOT NULL CHECK((JSON_VALID("settings") OR "settings" IS NULL)),
	SERIAL PRIMARY KEY
);
CREATE TABLE IF NOT EXISTS "socialaccount_socialtoken" (
	"id"	integer NOT NULL,
	"token"	text NOT NULL,
	"token_secret"	text NOT NULL,
	"expires_at"	datetime,
	"account_id"	integer NOT NULL,
	"app_id"	integer,
	SERIAL PRIMARY KEY,
	FOREIGN KEY("account_id") REFERENCES "socialaccount_socialaccount"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("app_id") REFERENCES "socialaccount_socialapp"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "socialaccount_socialaccount" (
	"id"	integer NOT NULL,
	"provider"	varchar(200) NOT NULL,
	"uid"	varchar(191) NOT NULL,
	"last_login"	datetime NOT NULL,
	"date_joined"	datetime NOT NULL,
	"user_id"	integer NOT NULL,
	"extra_data"	text NOT NULL CHECK((JSON_VALID("extra_data") OR "extra_data" IS NULL)),
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	SERIAL PRIMARY KEY
);
CREATE TABLE IF NOT EXISTS "users_useraccount" (
	"id"	integer NOT NULL,
	"mobile_no"	varchar(12) NOT NULL,
	"account_type"	varchar(10) NOT NULL,
	"user_id"	integer NOT NULL UNIQUE,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	SERIAL PRIMARY KEY
);
CREATE TABLE IF NOT EXISTS "dashboard_customerdashboard" (
	"id"	integer NOT NULL,
	"customer_id"	bigint NOT NULL UNIQUE,
	FOREIGN KEY("customer_id") REFERENCES "users_useraccount"("id") DEFERRABLE INITIALLY DEFERRED,
	SERIAL PRIMARY KEY
);
CREATE TABLE IF NOT EXISTS "dashboard_sellerdashboard" (
	"id"	integer NOT NULL,
	"total_sales"	integer unsigned NOT NULL CHECK("total_sales" >= 0),
	"total_earnings"	decimal NOT NULL,
	"seller_id"	bigint NOT NULL UNIQUE,
	SERIAL PRIMARY KEY,
	FOREIGN KEY("seller_id") REFERENCES "users_useraccount"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "products_cart" (
	"id"	integer NOT NULL,
	"quantity"	integer unsigned NOT NULL CHECK("quantity" >= 0),
	"product_id"	bigint NOT NULL,
	"discounted_price"	decimal NOT NULL,
	"image"	varchar(200) NOT NULL,
	"user_id"	bigint NOT NULL,
	SERIAL PRIMARY KEY,
	FOREIGN KEY("user_id") REFERENCES "users_useraccount"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("product_id") REFERENCES "products_product"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "products_product" (
	"id"	integer NOT NULL,
	"name"	varchar(255) NOT NULL,
	"description"	text NOT NULL,
	"original_price"	decimal NOT NULL,
	"discounted_price"	decimal NOT NULL,
	"image"	varchar(100) NOT NULL,
	"product_id"	varchar(50) NOT NULL UNIQUE,
	"category_id"	bigint NOT NULL,
	"seller_id"	bigint NOT NULL,
	SERIAL PRIMARY KEY,
	FOREIGN KEY("seller_id") REFERENCES "users_useraccount"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("category_id") REFERENCES "categories_category"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "products_purchase" (
	"id"	integer NOT NULL,
	"quantity"	integer unsigned NOT NULL CHECK("quantity" >= 0),
	"purchase_date"	datetime NOT NULL,
	"product_id"	bigint NOT NULL,
	"customer_id"	bigint NOT NULL,
	SERIAL PRIMARY KEY,
	FOREIGN KEY("product_id") REFERENCES "products_product"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("customer_id") REFERENCES "users_useraccount"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "products_purchaseitem" (
	"id"	integer NOT NULL,
	"quantity"	integer unsigned NOT NULL CHECK("quantity" >= 0),
	"product_id"	bigint NOT NULL,
	"purchase_id"	bigint NOT NULL,
	SERIAL PRIMARY KEY,
	FOREIGN KEY("product_id") REFERENCES "products_product"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("purchase_id") REFERENCES "products_purchase"("id") DEFERRABLE INITIALLY DEFERRED
);
INSERT INTO "django_migrations" VALUES (1,'contenttypes','0001_initial','2024-09-15 12:26:19.169110');
INSERT INTO "django_migrations" VALUES (2,'auth','0001_initial','2024-09-15 12:26:19.323713');
INSERT INTO "django_migrations" VALUES (3,'account','0001_initial','2024-09-15 12:26:19.448941');
INSERT INTO "django_migrations" VALUES (4,'account','0002_email_max_length','2024-09-15 12:26:19.518245');
INSERT INTO "django_migrations" VALUES (5,'account','0003_alter_emailaddress_create_unique_verified_email','2024-09-15 12:26:19.600547');
INSERT INTO "django_migrations" VALUES (6,'account','0004_alter_emailaddress_drop_unique_email','2024-09-15 12:26:19.689333');
INSERT INTO "django_migrations" VALUES (7,'account','0005_emailaddress_idx_upper_email','2024-09-15 12:26:19.769134');
INSERT INTO "django_migrations" VALUES (8,'account','0006_emailaddress_lower','2024-09-15 12:26:19.837542');
INSERT INTO "django_migrations" VALUES (9,'account','0007_emailaddress_idx_email','2024-09-15 12:26:19.918849');
INSERT INTO "django_migrations" VALUES (10,'account','0008_emailaddress_unique_primary_email_fixup','2024-09-15 12:26:19.987861');
INSERT INTO "django_migrations" VALUES (11,'account','0009_emailaddress_unique_primary_email','2024-09-15 12:26:20.054500');
INSERT INTO "django_migrations" VALUES (12,'admin','0001_initial','2024-09-15 12:26:20.201657');
INSERT INTO "django_migrations" VALUES (13,'admin','0002_logentry_remove_auto_add','2024-09-15 12:26:20.269189');
INSERT INTO "django_migrations" VALUES (14,'admin','0003_logentry_add_action_flag_choices','2024-09-15 12:26:20.336880');
INSERT INTO "django_migrations" VALUES (15,'contenttypes','0002_remove_content_type_name','2024-09-15 12:26:20.419298');
INSERT INTO "django_migrations" VALUES (16,'auth','0002_alter_permission_name_max_length','2024-09-15 12:26:20.507240');
INSERT INTO "django_migrations" VALUES (17,'auth','0003_alter_user_email_max_length','2024-09-15 12:26:20.570219');
INSERT INTO "django_migrations" VALUES (18,'auth','0004_alter_user_username_opts','2024-09-15 12:26:20.653503');
INSERT INTO "django_migrations" VALUES (19,'auth','0005_alter_user_last_login_null','2024-09-15 12:26:20.720449');
INSERT INTO "django_migrations" VALUES (20,'auth','0006_require_contenttypes_0002','2024-09-15 12:26:20.786843');
INSERT INTO "django_migrations" VALUES (21,'auth','0007_alter_validators_add_error_messages','2024-09-15 12:26:20.870494');
INSERT INTO "django_migrations" VALUES (22,'auth','0008_alter_user_username_max_length','2024-09-15 12:26:20.963783');
INSERT INTO "django_migrations" VALUES (23,'auth','0009_alter_user_last_name_max_length','2024-09-15 12:26:21.038522');
INSERT INTO "django_migrations" VALUES (24,'auth','0010_alter_group_name_max_length','2024-09-15 12:26:21.105337');
INSERT INTO "django_migrations" VALUES (25,'auth','0011_update_proxy_permissions','2024-09-15 12:26:21.180964');
INSERT INTO "django_migrations" VALUES (26,'auth','0012_alter_user_first_name_max_length','2024-09-15 12:26:21.254483');
INSERT INTO "django_migrations" VALUES (27,'authtoken','0001_initial','2024-09-15 12:26:21.337358');
INSERT INTO "django_migrations" VALUES (28,'authtoken','0002_auto_20160226_1747','2024-09-15 12:26:21.428130');
INSERT INTO "django_migrations" VALUES (29,'authtoken','0003_tokenproxy','2024-09-15 12:26:21.505256');
INSERT INTO "django_migrations" VALUES (30,'authtoken','0004_alter_tokenproxy_options','2024-09-15 12:26:21.569489');
INSERT INTO "django_migrations" VALUES (31,'categories','0001_initial','2024-09-15 12:26:21.620055');
INSERT INTO "django_migrations" VALUES (32,'categories','0002_remove_category_description_category_slug','2024-09-15 12:26:21.689762');
INSERT INTO "django_migrations" VALUES (33,'products','0001_initial','2024-09-15 12:26:21.837482');
INSERT INTO "django_migrations" VALUES (34,'products','0002_alter_product_discounted_price_alter_product_image_and_more','2024-09-15 12:26:21.937764');
INSERT INTO "django_migrations" VALUES (35,'products','0003_purchase','2024-09-15 12:26:22.270228');
INSERT INTO "django_migrations" VALUES (36,'dashboard','0001_initial','2024-09-15 12:26:22.453969');
INSERT INTO "django_migrations" VALUES (37,'products','0004_cart','2024-09-15 12:26:22.570283');
INSERT INTO "django_migrations" VALUES (38,'sessions','0001_initial','2024-09-15 12:26:22.720964');
INSERT INTO "django_migrations" VALUES (39,'socialaccount','0001_initial','2024-09-15 12:26:22.878067');
INSERT INTO "django_migrations" VALUES (40,'socialaccount','0002_token_max_lengths','2024-09-15 12:26:22.973776');
INSERT INTO "django_migrations" VALUES (41,'socialaccount','0003_extra_data_default_dict','2024-09-15 12:26:23.054766');
INSERT INTO "django_migrations" VALUES (42,'socialaccount','0004_app_provider_id_settings','2024-09-15 12:26:23.127552');
INSERT INTO "django_migrations" VALUES (43,'socialaccount','0005_socialtoken_nullable_app','2024-09-15 12:26:23.209437');
INSERT INTO "django_migrations" VALUES (44,'socialaccount','0006_alter_socialaccount_extra_data','2024-09-15 12:26:23.290749');
INSERT INTO "django_migrations" VALUES (45,'users','0001_initial','2024-09-15 12:26:23.491732');
INSERT INTO "django_migrations" VALUES (46,'users','0002_useraccount_delete_user','2024-09-15 12:26:23.571969');
INSERT INTO "django_migrations" VALUES (47,'dashboard','0002_alter_customerdashboard_customer_and_more','2024-09-17 15:13:27.367093');
INSERT INTO "django_migrations" VALUES (48,'products','0005_cart_discounted_price_cart_image_alter_cart_user_and_more','2024-09-17 15:13:27.648274');
INSERT INTO "django_admin_log" VALUES (1,'2','user1',3,'',4,1,'2024-09-15 13:37:03.524615');
INSERT INTO "django_admin_log" VALUES (2,'3','user1',3,'',4,1,'2024-09-15 13:46:36.972554');
INSERT INTO "django_admin_log" VALUES (3,'5','ok_nahin',3,'',4,1,'2024-09-15 17:45:20.694222');
INSERT INTO "django_admin_log" VALUES (4,'6','nahin009',3,'',4,1,'2024-09-15 17:55:09.116709');
INSERT INTO "django_admin_log" VALUES (5,'1','T-shirt',1,'[{"added": {}}]',18,1,'2024-09-16 12:40:40.794540');
INSERT INTO "django_admin_log" VALUES (6,'2','Smartphone',1,'[{"added": {}}]',18,1,'2024-09-16 12:40:56.158060');
INSERT INTO "django_admin_log" VALUES (7,'3','Mens Shirt',1,'[{"added": {}}]',18,1,'2024-09-16 12:41:22.590303');
INSERT INTO "django_admin_log" VALUES (8,'4','Camera',1,'[{"added": {}}]',18,1,'2024-09-16 12:41:39.275224');
INSERT INTO "django_admin_log" VALUES (9,'5','Hats',1,'[{"added": {}}]',18,1,'2024-09-16 12:42:03.554894');
INSERT INTO "django_admin_log" VALUES (10,'8','user2',1,'[{"added": {}}]',4,1,'2024-09-16 12:43:08.436179');
INSERT INTO "django_admin_log" VALUES (11,'8','user2',2,'[{"changed": {"fields": ["First name", "Last name", "Email address"]}}]',4,1,'2024-09-16 12:43:21.820843');
INSERT INTO "django_admin_log" VALUES (12,'9','seller2',1,'[{"added": {}}]',4,1,'2024-09-16 12:43:43.710186');
INSERT INTO "django_admin_log" VALUES (13,'9','seller2',2,'[{"changed": {"fields": ["First name", "Last name", "Email address"]}}]',4,1,'2024-09-16 12:44:31.021093');
INSERT INTO "django_admin_log" VALUES (14,'7','Sarah lee',1,'[{"added": {}}]',14,1,'2024-09-16 12:44:50.231898');
INSERT INTO "django_admin_log" VALUES (15,'8','Nazmul Hasan Nahin',1,'[{"added": {}}]',14,1,'2024-09-16 12:45:00.983896');
INSERT INTO "django_admin_log" VALUES (16,'7','seller1',2,'[{"changed": {"fields": ["First name", "Last name"]}}]',4,1,'2024-09-16 12:46:38.109198');
INSERT INTO "django_admin_log" VALUES (17,'7','seller1',2,'[{"changed": {"fields": ["First name", "Last name"]}}]',4,1,'2024-09-16 12:47:39.895371');
INSERT INTO "django_admin_log" VALUES (18,'9','seller2',2,'[{"changed": {"fields": ["First name"]}}]',4,1,'2024-09-16 12:47:50.595798');
INSERT INTO "django_admin_log" VALUES (19,'4','user1',2,'[{"changed": {"fields": ["First name"]}}]',4,1,'2024-09-16 12:47:59.651974');
INSERT INTO "django_admin_log" VALUES (20,'8','user2',2,'[{"changed": {"fields": ["First name", "Last name"]}}]',4,1,'2024-09-16 12:48:12.293958');
INSERT INTO "django_admin_log" VALUES (21,'7','seller1',2,'[{"changed": {"fields": ["Last name"]}}]',4,1,'2024-09-16 12:48:26.077257');
INSERT INTO "django_admin_log" VALUES (22,'9','seller2',2,'[{"changed": {"fields": ["Last name"]}}]',4,1,'2024-09-16 12:48:30.774285');
INSERT INTO "django_admin_log" VALUES (23,'4','rgh',3,'',15,1,'2024-09-16 12:56:26.662373');
INSERT INTO "django_admin_log" VALUES (24,'3','rfg',3,'',15,1,'2024-09-16 12:56:26.745617');
INSERT INTO "django_admin_log" VALUES (25,'2','rfg',3,'',15,1,'2024-09-16 12:56:26.803556');
INSERT INTO "django_admin_log" VALUES (26,'1','rfg',3,'',15,1,'2024-09-16 12:56:26.871350');
INSERT INTO "django_admin_log" VALUES (27,'5','rgh',3,'',15,1,'2024-09-16 12:58:00.357952');
INSERT INTO "django_admin_log" VALUES (28,'7','seller1',2,'[]',4,1,'2024-09-16 13:08:21.796913');
INSERT INTO "django_admin_log" VALUES (29,'6','Seller nahin1',2,'[{"changed": {"fields": ["Mobile no"]}}]',14,1,'2024-09-16 14:08:08.160531');
INSERT INTO "django_admin_log" VALUES (30,'11','seller4',1,'[{"added": {}}]',4,1,'2024-09-16 14:33:54.046505');
INSERT INTO "django_admin_log" VALUES (31,'11','seller4',2,'[{"changed": {"fields": ["First name", "Last name", "Email address"]}}]',4,1,'2024-09-16 14:34:28.167892');
INSERT INTO "django_admin_log" VALUES (32,'10','seller4 seller4',1,'[{"added": {}}]',14,1,'2024-09-16 14:34:55.891468');
INSERT INTO "django_admin_log" VALUES (33,'16','iPhone 13 Pro Maxd',3,'',15,1,'2024-09-16 14:38:06.918671');
INSERT INTO "django_admin_log" VALUES (34,'15','iPhone 13 Pro Maxd',3,'',15,1,'2024-09-16 14:38:06.985677');
INSERT INTO "django_admin_log" VALUES (35,'14','iPhone 13 Pro Maxd',3,'',15,1,'2024-09-16 14:38:07.061790');
INSERT INTO "django_admin_log" VALUES (36,'13','iPhone 13 Pro Max',3,'',15,1,'2024-09-16 14:38:07.135749');
INSERT INTO "django_admin_log" VALUES (37,'12','Champion Men''S Classic T-Shirt, Everyday Tee For Men, Comfortable Soft Men''S T-Shirt',3,'',15,1,'2024-09-16 14:38:07.211480');
INSERT INTO "django_admin_log" VALUES (38,'11','Champion Men''S Classic T-Shirt, Everyday Tee For Men, Comfortable Soft Men''S T-Shirt',3,'',15,1,'2024-09-16 14:38:07.293618');
INSERT INTO "django_admin_log" VALUES (39,'10','Champion Men''S Classic T-Shirt, Everyday Tee For Men, Comfortable Soft Men''S T-Shirt',3,'',15,1,'2024-09-16 14:38:07.361493');
INSERT INTO "django_admin_log" VALUES (40,'7','seller1',3,'',4,1,'2024-09-16 14:38:21.215307');
INSERT INTO "django_admin_log" VALUES (41,'7','seller1',3,'',4,1,'2024-09-16 14:38:45.133728');
INSERT INTO "django_admin_log" VALUES (42,'6','Seller nahin1',3,'',14,1,'2024-09-16 14:38:58.363169');
INSERT INTO "django_admin_log" VALUES (43,'7','seller1',3,'',4,1,'2024-09-16 14:39:09.378711');
INSERT INTO "django_admin_log" VALUES (44,'6','Monitor',1,'[{"added": {}}]',18,1,'2024-09-16 14:44:04.739898');
INSERT INTO "django_admin_log" VALUES (45,'8','Jeans',1,'[{"added": {}}]',18,1,'2024-09-19 12:57:09.686616');
INSERT INTO "django_admin_log" VALUES (46,'9','Sports',1,'[{"added": {}}]',18,1,'2024-09-19 12:57:21.306768');
INSERT INTO "django_admin_log" VALUES (47,'10','Sunglasses',1,'[{"added": {}}]',18,1,'2024-09-19 12:57:30.914736');
INSERT INTO "django_admin_log" VALUES (48,'11','Sneakers & Athletic',1,'[{"added": {}}]',18,1,'2024-09-19 12:57:39.123455');
INSERT INTO "django_admin_log" VALUES (49,'12','Furniture',1,'[{"added": {}}]',18,1,'2024-09-19 12:58:00.067799');
INSERT INTO "django_admin_log" VALUES (50,'32','New Fashion Casual Men Shoes Fashion',1,'[{"added": {}}]',15,1,'2024-09-19 15:01:03.047888');
INSERT INTO "django_admin_log" VALUES (51,'13','Watches',1,'[{"added": {}}]',18,1,'2024-09-19 15:02:09.750097');
INSERT INTO "django_admin_log" VALUES (52,'33','NAVIFORCE Man''s Casual Wild Quartz Wristwatch Waterproof Stainless Steel Watches for Men',1,'[{"added": {}}]',15,1,'2024-09-19 15:06:04.288808');
INSERT INTO "django_admin_log" VALUES (53,'34','Citizen Men''s Eco-Drive Sport Luxury World Chronograph Atomic Time Keeping Watch in Stainless Steel, Blue Dial (Model: AT8020-54L)',1,'[{"added": {}}]',15,1,'2024-09-19 15:07:17.874313');
INSERT INTO "django_admin_log" VALUES (54,'35','HAGGAR Mens Stretch Classic Fit Cargo Pant (Regular and Big and Tall Sizes)',1,'[{"added": {}}]',15,1,'2024-09-19 15:08:09.907223');
INSERT INTO "django_admin_log" VALUES (55,'36','Insulated Water Bottle w/Handle, Half Gallon, Fence Hook',1,'[{"added": {}}]',15,1,'2024-09-19 15:09:47.301117');
INSERT INTO "django_admin_log" VALUES (56,'37','AND1 Over the Door Mini Basketball Hoop: 18x12 Shatterproof Backboard, 2 Mini Basketballs',1,'[{"added": {}}]',15,1,'2024-09-19 15:11:10.624037');
INSERT INTO "django_admin_log" VALUES (57,'38','WLIVE Wood Lift Top Coffee Table with Hidden Compartment and Adjustable Storage Shelf, Lift Tabletop Dining Table for Home Living Room, Office, Rustic Oak',1,'[{"added": {}}]',15,1,'2024-09-19 15:12:30.584215');
INSERT INTO "django_admin_log" VALUES (58,'39','Yoobure Tree Bookshelf - 6 Shelf Retro Floor Standing Bookcase, Tall Wood Book Storage Rack for CDs/Movies/Books, Utility Book Organizer Shelves for Bedroom, Living Room, Home Office',1,'[{"added": {}}]',15,1,'2024-09-19 15:13:13.531025');
INSERT INTO "django_admin_log" VALUES (59,'40','OXO Good Grips Sweep & Swipe Laptop Cleaner, White, One Size',1,'[{"added": {}}]',15,1,'2024-09-19 15:14:24.176546');
INSERT INTO "django_admin_log" VALUES (60,'35','HAGGAR Mens Stretch Classic Fit Cargo Jeans Pant (Regular and Big and Tall Sizes)',2,'[{"changed": {"fields": ["Name"]}}]',15,1,'2024-09-19 15:15:11.030355');
INSERT INTO "django_admin_log" VALUES (61,'31','Richman Men’s  Jeans Mid Indigo Color Denim Pant',2,'[{"changed": {"fields": ["Name"]}}]',15,1,'2024-09-19 15:15:20.534455');
INSERT INTO "django_admin_log" VALUES (62,'41','Mademark x SpongeBob SquarePants T-Shirts  - SpongeBob I am 6 Years Old Birthday Party T-Shirt',1,'[{"added": {}}]',15,1,'2024-09-19 15:16:44.640165');
INSERT INTO "django_admin_log" VALUES (63,'41','Mademark x SpongeBob SquarePants clothes T-Shirts  - SpongeBob I am 6 Years Old Birthday Party T-Shirt',2,'[{"changed": {"fields": ["Name"]}}]',15,1,'2024-09-19 15:17:09.347233');
INSERT INTO "django_admin_log" VALUES (64,'22','MENS L/S SHIRT-PURPLE STRIPE clothes T-Shirts',2,'[{"changed": {"fields": ["Name"]}}]',15,1,'2024-09-19 15:17:24.382285');
INSERT INTO "django_admin_log" VALUES (65,'42','WMP Eyewear Round Sunglasses  | Polarized UV Protection | Trendy Sunglasses for Women | Retro Designer Style',1,'[{"added": {}}]',15,1,'2024-09-19 15:19:05.901909');
INSERT INTO "django_admin_log" VALUES (66,'43','Disney Lion King Hakuna Matata T-Shirt for T-Shirts',1,'[{"added": {}}]',15,1,'2024-09-19 15:20:32.540850');
INSERT INTO "django_admin_log" VALUES (67,'44','SAMSUNG Galaxy S22 Ultra smartphone',1,'[{"added": {}}]',15,1,'2024-09-19 15:22:17.640237');
INSERT INTO "django_admin_log" VALUES (68,'45','SAMSUNG Galaxy Z Fold 6 AI smartphone',1,'[{"added": {}}]',15,1,'2024-09-19 15:23:29.848285');
INSERT INTO "django_admin_log" VALUES (69,'9','Realme GT Master Edition - Official smartphone',2,'[{"changed": {"fields": ["Name", "Description"]}}]',15,1,'2024-09-19 15:23:55.861016');
INSERT INTO "django_admin_log" VALUES (70,'34','Citizen Men''s Eco-Drive Sport Luxury World Chronograph Atomic Time Keeping Watch in Stainless Steel, Blue Dial (Model: AT8020-54L) watches',2,'[{"changed": {"fields": ["Name"]}}]',15,1,'2024-09-19 15:25:34.181750');
INSERT INTO "django_admin_log" VALUES (71,'42','WMP Eyewear Round Sunglasses  fashion | Polarized UV Protection | Trendy Sunglasses for Women | Retro Designer Style',2,'[{"changed": {"fields": ["Name"]}}]',15,1,'2024-09-19 15:26:08.701945');
INSERT INTO "django_admin_log" VALUES (72,'31','Richman Men’s fashion   Jeans Mid Indigo Color Denim Pant',2,'[{"changed": {"fields": ["Name"]}}]',15,1,'2024-09-19 15:26:28.782906');
INSERT INTO "django_admin_log" VALUES (73,'14','bags',1,'[{"added": {}}]',18,1,'2024-09-19 15:27:03.831178');
INSERT INTO "django_admin_log" VALUES (74,'46','BOSTANTEN Quilted Crossbody bags Bags for Women Vegan Leather Purses Small Shoulder Handbags with Wide Strap',1,'[{"added": {}}]',15,1,'2024-09-19 15:27:48.971277');
INSERT INTO "django_admin_log" VALUES (75,'47','FashionPuzzle Small Crescent Shoulder Bag Underarm Purse',1,'[{"added": {}}]',15,1,'2024-09-19 15:28:30.131126');
INSERT INTO "django_admin_log" VALUES (76,'48','LOVEVOOK Laptop Backpack for Women, 15.6 Inch Work Business Backpacks Purse with USB Port, Large Capacity Nurse Bag College Bookbag for School, Waterproof Casual Daypack for Travel,Black-White-Brown',1,'[{"added": {}}]',15,1,'2024-09-19 15:29:26.849240');
INSERT INTO "django_admin_log" VALUES (77,'48','LOVEVOOK Laptop Backpack for bags Women, 15.6 Inch Work Business Backpacks Purse with USB Port, Large Capacity Nurse Bag College Bookbag for School, Waterproof Casual Daypack for Travel,Black-White-Br',2,'[{"changed": {"fields": ["Name"]}}]',15,1,'2024-09-19 15:29:40.077565');
INSERT INTO "django_admin_log" VALUES (78,'47','FashionPuzzle Small Crescent bags Shoulder Bag Underarm Purse',2,'[{"changed": {"fields": ["Name"]}}]',15,1,'2024-09-19 15:29:55.380132');
INSERT INTO "django_content_type" VALUES (1,'admin','logentry');
INSERT INTO "django_content_type" VALUES (2,'auth','permission');
INSERT INTO "django_content_type" VALUES (3,'auth','group');
INSERT INTO "django_content_type" VALUES (4,'auth','user');
INSERT INTO "django_content_type" VALUES (5,'contenttypes','contenttype');
INSERT INTO "django_content_type" VALUES (6,'sessions','session');
INSERT INTO "django_content_type" VALUES (7,'authtoken','token');
INSERT INTO "django_content_type" VALUES (8,'authtoken','tokenproxy');
INSERT INTO "django_content_type" VALUES (9,'account','emailaddress');
INSERT INTO "django_content_type" VALUES (10,'account','emailconfirmation');
INSERT INTO "django_content_type" VALUES (11,'socialaccount','socialaccount');
INSERT INTO "django_content_type" VALUES (12,'socialaccount','socialapp');
INSERT INTO "django_content_type" VALUES (13,'socialaccount','socialtoken');
INSERT INTO "django_content_type" VALUES (14,'users','useraccount');
INSERT INTO "django_content_type" VALUES (15,'products','product');
INSERT INTO "django_content_type" VALUES (16,'products','purchase');
INSERT INTO "django_content_type" VALUES (17,'products','cart');
INSERT INTO "django_content_type" VALUES (18,'categories','category');
INSERT INTO "django_content_type" VALUES (19,'dashboard','customerdashboard');
INSERT INTO "django_content_type" VALUES (20,'dashboard','sellerdashboard');
INSERT INTO "django_content_type" VALUES (21,'products','purchaseitem');
INSERT INTO "auth_permission" VALUES (1,1,'add_logentry','Can add log entry');
INSERT INTO "auth_permission" VALUES (2,1,'change_logentry','Can change log entry');
INSERT INTO "auth_permission" VALUES (3,1,'delete_logentry','Can delete log entry');
INSERT INTO "auth_permission" VALUES (4,1,'view_logentry','Can view log entry');
INSERT INTO "auth_permission" VALUES (5,2,'add_permission','Can add permission');
INSERT INTO "auth_permission" VALUES (6,2,'change_permission','Can change permission');
INSERT INTO "auth_permission" VALUES (7,2,'delete_permission','Can delete permission');
INSERT INTO "auth_permission" VALUES (8,2,'view_permission','Can view permission');
INSERT INTO "auth_permission" VALUES (9,3,'add_group','Can add group');
INSERT INTO "auth_permission" VALUES (10,3,'change_group','Can change group');
INSERT INTO "auth_permission" VALUES (11,3,'delete_group','Can delete group');
INSERT INTO "auth_permission" VALUES (12,3,'view_group','Can view group');
INSERT INTO "auth_permission" VALUES (13,4,'add_user','Can add user');
INSERT INTO "auth_permission" VALUES (14,4,'change_user','Can change user');
INSERT INTO "auth_permission" VALUES (15,4,'delete_user','Can delete user');
INSERT INTO "auth_permission" VALUES (16,4,'view_user','Can view user');
INSERT INTO "auth_permission" VALUES (17,5,'add_contenttype','Can add content type');
INSERT INTO "auth_permission" VALUES (18,5,'change_contenttype','Can change content type');
INSERT INTO "auth_permission" VALUES (19,5,'delete_contenttype','Can delete content type');
INSERT INTO "auth_permission" VALUES (20,5,'view_contenttype','Can view content type');
INSERT INTO "auth_permission" VALUES (21,6,'add_session','Can add session');
INSERT INTO "auth_permission" VALUES (22,6,'change_session','Can change session');
INSERT INTO "auth_permission" VALUES (23,6,'delete_session','Can delete session');
INSERT INTO "auth_permission" VALUES (24,6,'view_session','Can view session');
INSERT INTO "auth_permission" VALUES (25,7,'add_token','Can add Token');
INSERT INTO "auth_permission" VALUES (26,7,'change_token','Can change Token');
INSERT INTO "auth_permission" VALUES (27,7,'delete_token','Can delete Token');
INSERT INTO "auth_permission" VALUES (28,7,'view_token','Can view Token');
INSERT INTO "auth_permission" VALUES (29,8,'add_tokenproxy','Can add Token');
INSERT INTO "auth_permission" VALUES (30,8,'change_tokenproxy','Can change Token');
INSERT INTO "auth_permission" VALUES (31,8,'delete_tokenproxy','Can delete Token');
INSERT INTO "auth_permission" VALUES (32,8,'view_tokenproxy','Can view Token');
INSERT INTO "auth_permission" VALUES (33,9,'add_emailaddress','Can add email address');
INSERT INTO "auth_permission" VALUES (34,9,'change_emailaddress','Can change email address');
INSERT INTO "auth_permission" VALUES (35,9,'delete_emailaddress','Can delete email address');
INSERT INTO "auth_permission" VALUES (36,9,'view_emailaddress','Can view email address');
INSERT INTO "auth_permission" VALUES (37,10,'add_emailconfirmation','Can add email confirmation');
INSERT INTO "auth_permission" VALUES (38,10,'change_emailconfirmation','Can change email confirmation');
INSERT INTO "auth_permission" VALUES (39,10,'delete_emailconfirmation','Can delete email confirmation');
INSERT INTO "auth_permission" VALUES (40,10,'view_emailconfirmation','Can view email confirmation');
INSERT INTO "auth_permission" VALUES (41,11,'add_socialaccount','Can add social account');
INSERT INTO "auth_permission" VALUES (42,11,'change_socialaccount','Can change social account');
INSERT INTO "auth_permission" VALUES (43,11,'delete_socialaccount','Can delete social account');
INSERT INTO "auth_permission" VALUES (44,11,'view_socialaccount','Can view social account');
INSERT INTO "auth_permission" VALUES (45,12,'add_socialapp','Can add social application');
INSERT INTO "auth_permission" VALUES (46,12,'change_socialapp','Can change social application');
INSERT INTO "auth_permission" VALUES (47,12,'delete_socialapp','Can delete social application');
INSERT INTO "auth_permission" VALUES (48,12,'view_socialapp','Can view social application');
INSERT INTO "auth_permission" VALUES (49,13,'add_socialtoken','Can add social application token');
INSERT INTO "auth_permission" VALUES (50,13,'change_socialtoken','Can change social application token');
INSERT INTO "auth_permission" VALUES (51,13,'delete_socialtoken','Can delete social application token');
INSERT INTO "auth_permission" VALUES (52,13,'view_socialtoken','Can view social application token');
INSERT INTO "auth_permission" VALUES (53,14,'add_useraccount','Can add user account');
INSERT INTO "auth_permission" VALUES (54,14,'change_useraccount','Can change user account');
INSERT INTO "auth_permission" VALUES (55,14,'delete_useraccount','Can delete user account');
INSERT INTO "auth_permission" VALUES (56,14,'view_useraccount','Can view user account');
INSERT INTO "auth_permission" VALUES (57,15,'add_product','Can add product');
INSERT INTO "auth_permission" VALUES (58,15,'change_product','Can change product');
INSERT INTO "auth_permission" VALUES (59,15,'delete_product','Can delete product');
INSERT INTO "auth_permission" VALUES (60,15,'view_product','Can view product');
INSERT INTO "auth_permission" VALUES (61,16,'add_purchase','Can add purchase');
INSERT INTO "auth_permission" VALUES (62,16,'change_purchase','Can change purchase');
INSERT INTO "auth_permission" VALUES (63,16,'delete_purchase','Can delete purchase');
INSERT INTO "auth_permission" VALUES (64,16,'view_purchase','Can view purchase');
INSERT INTO "auth_permission" VALUES (65,17,'add_cart','Can add cart');
INSERT INTO "auth_permission" VALUES (66,17,'change_cart','Can change cart');
INSERT INTO "auth_permission" VALUES (67,17,'delete_cart','Can delete cart');
INSERT INTO "auth_permission" VALUES (68,17,'view_cart','Can view cart');
INSERT INTO "auth_permission" VALUES (69,18,'add_category','Can add category');
INSERT INTO "auth_permission" VALUES (70,18,'change_category','Can change category');
INSERT INTO "auth_permission" VALUES (71,18,'delete_category','Can delete category');
INSERT INTO "auth_permission" VALUES (72,18,'view_category','Can view category');
INSERT INTO "auth_permission" VALUES (73,19,'add_customerdashboard','Can add customer dashboard');
INSERT INTO "auth_permission" VALUES (74,19,'change_customerdashboard','Can change customer dashboard');
INSERT INTO "auth_permission" VALUES (75,19,'delete_customerdashboard','Can delete customer dashboard');
INSERT INTO "auth_permission" VALUES (76,19,'view_customerdashboard','Can view customer dashboard');
INSERT INTO "auth_permission" VALUES (77,20,'add_sellerdashboard','Can add seller dashboard');
INSERT INTO "auth_permission" VALUES (78,20,'change_sellerdashboard','Can change seller dashboard');
INSERT INTO "auth_permission" VALUES (79,20,'delete_sellerdashboard','Can delete seller dashboard');
INSERT INTO "auth_permission" VALUES (80,20,'view_sellerdashboard','Can view seller dashboard');
INSERT INTO "auth_permission" VALUES (81,21,'add_purchaseitem','Can add purchase item');
INSERT INTO "auth_permission" VALUES (82,21,'change_purchaseitem','Can change purchase item');
INSERT INTO "auth_permission" VALUES (83,21,'delete_purchaseitem','Can delete purchase item');
INSERT INTO "auth_permission" VALUES (84,21,'view_purchaseitem','Can view purchase item');
INSERT INTO "auth_user" VALUES (1,'pbkdf2_sha256$720000$KHXAFCDdBgd7DBE6TDBZNx$nd/W9adPsscdRkbjEiUv23m1jcj7c3OpwiP1to5cTIs=','2024-09-19 12:57:00.785131',1,'nahin','','n@g.com',1,1,'2024-09-15 12:27:06.622458','');
INSERT INTO "auth_user" VALUES (4,'pbkdf2_sha256$720000$BmcUC39EGmmFNRKUE9NkuM$YFK50yqoy72xGtVvlDD5GCbF0YrnAtvbkvv5GnJgGZE=','2024-09-16 13:59:18.678064',0,'user1','Nahin','rajibami23@gmail.com',0,1,'2024-09-15 13:48:52','user');
INSERT INTO "auth_user" VALUES (7,'pbkdf2_sha256$720000$nHrIbX8XQwZmxYljolLOlL$GMTNGElSuqZs7kugJq+A8aIJdLqXpXG/sQk+4PGGUhg=','2024-09-16 14:07:11.017245',0,'seller1','nahin1','j.av.h.i.rm.ol.ase@gmail.com',0,1,'2024-09-16 06:24:42','Seller');
INSERT INTO "auth_user" VALUES (8,'pbkdf2_sha256$720000$0yiV6ryf4OVKf09ysUIPRX$O7ji9/u0l4HVE06Dus99+OREGZPk7qxHd2HwbvP4WWI=','2024-09-19 14:57:29.826017',0,'user2','nazmul','tinytmp+brjuv@gmail.com',0,1,'2024-09-16 12:43:07','user');
INSERT INTO "auth_user" VALUES (9,'pbkdf2_sha256$720000$ArI2LJMsBwK4amAhxywS50$aAC5ABcHHOIxwKP15xDX7XdtGBP9aElq6Xuq4T+BJU4=','2024-09-19 14:56:21.044979',0,'seller2','lee2','infusedr.aind.ro.p.s1.26@gmail.com',0,1,'2024-09-16 12:43:43','seller d');
INSERT INTO "auth_user" VALUES (10,'pbkdf2_sha256$720000$S5IRhylHw7NuN2gjcVlyFM$RWBZiZgSvK6dh3/8qR2vLphIkLbplMKFgze5sSSsm+k=','2024-09-16 14:40:17.223616',0,'seller3','seller3','lov.e.las.can.tte@gmail.com',0,1,'2024-09-16 14:31:47.146609','seller3');
INSERT INTO "auth_user" VALUES (11,'pbkdf2_sha256$720000$v9OgpNmJENXcjX7dfDIRjB$41XWScM2ncsA7J8ljg3zF756+oMGg8DcOxfueCFx+ik=','2024-09-16 14:35:08.357468',0,'seller4','seller4','ro.sh.e.nabd.ullah.2.7@gmail.com',0,1,'2024-09-16 14:33:53','seller4');
INSERT INTO "authtoken_token" VALUES ('85aa1573d655cd7f385bd35c50f0885acb4b5015','2024-09-15 13:59:51.626509',4);
INSERT INTO "authtoken_token" VALUES ('a82c1ec0be9addb589a2b733e201db2a07ff2c06','2024-09-16 06:25:34.627951',7);
INSERT INTO "authtoken_token" VALUES ('63f840606524cf559ccc3c4746547be5f7d0a82a','2024-09-16 12:45:53.287105',9);
INSERT INTO "authtoken_token" VALUES ('af9bb94683db601014961d159b8f0ee3c153dec3','2024-09-16 14:32:27.729963',10);
INSERT INTO "authtoken_token" VALUES ('7248c21c9a590904e2a4c6046c15dafacb29ff22','2024-09-16 14:35:08.226394',11);
INSERT INTO "authtoken_token" VALUES ('2ce358985e6b1f77370d86b49f9a03eaffd265a0','2024-09-16 18:08:08.854393',8);
INSERT INTO "categories_category" VALUES (1,'T-shirt','t-shirt');
INSERT INTO "categories_category" VALUES (2,'Smartphone','smartphone');
INSERT INTO "categories_category" VALUES (3,'Mens Shirt','mens-shirt');
INSERT INTO "categories_category" VALUES (4,'Camera','camera');
INSERT INTO "categories_category" VALUES (5,'Hats','hats');
INSERT INTO "categories_category" VALUES (6,'Monitor','monitor');
INSERT INTO "categories_category" VALUES (7,'Computer Gadet','computer-gadet');
INSERT INTO "categories_category" VALUES (8,'Jeans','jeans');
INSERT INTO "categories_category" VALUES (9,'Sports','sports');
INSERT INTO "categories_category" VALUES (10,'Sunglasses','sunglasses');
INSERT INTO "categories_category" VALUES (11,'Sneakers & Athletic','sneakers-athletic');
INSERT INTO "categories_category" VALUES (12,'Furniture','furniture');
INSERT INTO "categories_category" VALUES (13,'Watches','watches');
INSERT INTO "categories_category" VALUES (14,'bags','bags');
INSERT INTO "django_session" VALUES ('qzoy3w3fylk9gokf4zesmgxhv657td25','.eJxVjEEOwiAQRe_C2pDC4AAu3XsGMsygVA1NSrsy3l2bdKHb_977L5VoXWpae5nTKOqkjDr8bpn4UdoG5E7tNmme2jKPWW-K3mnXl0nK87y7fweVev3WbKwHC1DswCjoJXImFyQghujBmSgeMF7JZ2uQIhAOUhzK0UUCy-r9AcNpNyI:1spoLd:gOjl9d48b617vEp8Yp6dY4AzkGtK0MaqyD3FNYYo6WE','2024-09-29 12:27:25.109380');
INSERT INTO "django_session" VALUES ('m9bnd2f3yss8fnekn9gsjvtgq1vwfuhp','.eJxVjEEOwiAQRe_C2pDC4AAu3XsGMsygVA1NSrsy3l2bdKHb_977L5VoXWpae5nTKOqkjDr8bpn4UdoG5E7tNmme2jKPWW-K3mnXl0nK87y7fweVev3WbKwHC1DswCjoJXImFyQghujBmSgeMF7JZ2uQIhAOUhzK0UUCy-r9AcNpNyI:1sppNT:3_66JSm_k2Bwh_DyXcwM7IP_FF27mAGUradAEGO7jWM','2024-09-29 13:33:23.250862');
INSERT INTO "django_session" VALUES ('0t0fvpu15azx6mpyztse2w97byt1rxky','.eJxVjMsOwiAQRf-FtSEMlJdL934DAWaQqoGktCvjv2uTLnR7zzn3xULc1hq2QUuYkZ3ZxE6_W4r5QW0HeI_t1nnubV3mxHeFH3Twa0d6Xg7376DGUb-10S67nDWpYqQVPhkFoohospOEVgKBVxNIj9aIqAicE4Tag0sEBS17fwDMvDdO:1sppn5:JtNO0Wpdgte9ZvzKAJ1DYoXo4W3tOVZQXMaz1yneVSs','2024-09-29 13:59:51.861445');
INSERT INTO "django_session" VALUES ('zvlqzfj8teoz3ehxuxm3l13vq1ncro7u','.eJxVjMsOwiAQRf-FtSEMlJdL934DAWaQqoGktCvjv2uTLnR7zzn3xULc1hq2QUuYkZ3ZxE6_W4r5QW0HeI_t1nnubV3mxHeFH3Twa0d6Xg7376DGUb-10S67nDWpYqQVPhkFoohospOEVgKBVxNIj9aIqAicE4Tag0sEBS17fwDMvDdO:1sppnT:VvG_aExw7AKAfKcTJrnRRfOj_dIf7-X3Kuw7teBbqmk','2024-09-29 14:00:15.503763');
INSERT INTO "django_session" VALUES ('dsv5v4bu9y938boxy4cp3zdv27wpovo7','.eJxVjMsOwiAQRf-FtSEMlJdL934DAWaQqoGktCvjv2uTLnR7zzn3xULc1hq2QUuYkZ3ZxE6_W4r5QW0HeI_t1nnubV3mxHeFH3Twa0d6Xg7376DGUb-10S67nDWpYqQVPhkFoohospOEVgKBVxNIj9aIqAicE4Tag0sEBS17fwDMvDdO:1sppno:p2JfPlWfkCCXpMWXPQPenP4TCpm01uo8WPvwgdro9mc','2024-09-29 14:00:36.249105');
INSERT INTO "django_session" VALUES ('oeutvazygiirh3iqf1dq461jsbh6ajka','.eJxVjMsOwiAQRf-FtSEMlJdL934DAWaQqoGktCvjv2uTLnR7zzn3xULc1hq2QUuYkZ3ZxE6_W4r5QW0HeI_t1nnubV3mxHeFH3Twa0d6Xg7376DGUb-10S67nDWpYqQVPhkFoohospOEVgKBVxNIj9aIqAicE4Tag0sEBS17fwDMvDdO:1sppnz:W9Suo6Yft9voPm0VxriaLqdo7vxnFV5Cvpp6h94NdqE','2024-09-29 14:00:47.069140');
INSERT INTO "django_session" VALUES ('w8eesi2qt9goah1shm0009r2sku4mb2b','.eJxVjMsOwiAQRf-FtSEMlJdL934DAWaQqoGktCvjv2uTLnR7zzn3xULc1hq2QUuYkZ3ZxE6_W4r5QW0HeI_t1nnubV3mxHeFH3Twa0d6Xg7376DGUb-10S67nDWpYqQVPhkFoohospOEVgKBVxNIj9aIqAicE4Tag0sEBS17fwDMvDdO:1sppoL:ECmm-oLSJYMFYukriRpRIkeAK3gUMP0RfctqZ2R8MQk','2024-09-29 14:01:09.616311');
INSERT INTO "django_session" VALUES ('u7ytyaaliu72bcmbq21q4j4wqxw9xieb','.eJxVjMsOwiAQRf-FtSEMlJdL934DAWaQqoGktCvjv2uTLnR7zzn3xULc1hq2QUuYkZ3ZxE6_W4r5QW0HeI_t1nnubV3mxHeFH3Twa0d6Xg7376DGUb-10S67nDWpYqQVPhkFoohospOEVgKBVxNIj9aIqAicE4Tag0sEBS17fwDMvDdO:1spprH:kudLXvDz2ysQSSilY7q90Tylt1UrCHoWGQ4BDw6FQyA','2024-09-29 14:04:11.725600');
INSERT INTO "django_session" VALUES ('a6c4fg2gvslw9xjl11n2y2k1ce1jp8rj','.eJxVjMsOwiAQRf-FtSEMlJdL934DAWaQqoGktCvjv2uTLnR7zzn3xULc1hq2QUuYkZ3ZxE6_W4r5QW0HeI_t1nnubV3mxHeFH3Twa0d6Xg7376DGUb-10S67nDWpYqQVPhkFoohospOEVgKBVxNIj9aIqAicE4Tag0sEBS17fwDMvDdO:1spprb:OpRFcjsHnlOcTYA8wMhDxfNGfDdCI05ES0a_nfG2roA','2024-09-29 14:04:31.640408');
INSERT INTO "django_session" VALUES ('gjbpjsvp8nk5telgwc4jfbjt7kjrhupc','.eJxVjMsOwiAQRf-FtSEMlJdL934DAWaQqoGktCvjv2uTLnR7zzn3xULc1hq2QUuYkZ3ZxE6_W4r5QW0HeI_t1nnubV3mxHeFH3Twa0d6Xg7376DGUb-10S67nDWpYqQVPhkFoohospOEVgKBVxNIj9aIqAicE4Tag0sEBS17fwDMvDdO:1spprp:IUTn2eitHS6N7Ek1AQ6lU2AA10f4410rqHUUHjt9BU4','2024-09-29 14:04:45.776015');
INSERT INTO "django_session" VALUES ('vv73mj7cov206brcqnffa22ovjigvrga','.eJxVjMsOwiAQRf-FtSEMlJdL934DAWaQqoGktCvjv2uTLnR7zzn3xULc1hq2QUuYkZ3ZxE6_W4r5QW0HeI_t1nnubV3mxHeFH3Twa0d6Xg7376DGUb-10S67nDWpYqQVPhkFoohospOEVgKBVxNIj9aIqAicE4Tag0sEBS17fwDMvDdO:1sppsW:Mu2kImuIuaBJhJA3RuI9iaO42W4ddJLI8xMFuglOe3s','2024-09-29 14:05:28.918607');
INSERT INTO "django_session" VALUES ('pi7m75e90inzfrxh9set18zidrw5kwgg','.eJxVjMsOwiAQRf-FtSEMlJdL934DAWaQqoGktCvjv2uTLnR7zzn3xULc1hq2QUuYkZ3ZxE6_W4r5QW0HeI_t1nnubV3mxHeFH3Twa0d6Xg7376DGUb-10S67nDWpYqQVPhkFoohospOEVgKBVxNIj9aIqAicE4Tag0sEBS17fwDMvDdO:1spq4E:2pO4eXB2jy9NbDrRjEsc69OWoZGlfGarnrQq0RyoA0A','2024-09-29 14:17:34.273862');
INSERT INTO "django_session" VALUES ('9b2ygcqtfcec23ly73onthq31gcxawmx','.eJxVjMsOwiAQRf-FtSEMlJdL934DAWaQqoGktCvjv2uTLnR7zzn3xULc1hq2QUuYkZ3ZxE6_W4r5QW0HeI_t1nnubV3mxHeFH3Twa0d6Xg7376DGUb-10S67nDWpYqQVPhkFoohospOEVgKBVxNIj9aIqAicE4Tag0sEBS17fwDMvDdO:1spq5V:Quw3I9pd_YRKxK-W3ir4hSLIBb5aen-OW_nZGSJ4m5g','2024-09-29 14:18:53.395119');
INSERT INTO "django_session" VALUES ('00mflv4fhd59wi7pbc9hh3d35481qf9v','.eJxVjMsOwiAQRf-FtSEMlJdL934DAWaQqoGktCvjv2uTLnR7zzn3xULc1hq2QUuYkZ3ZxE6_W4r5QW0HeI_t1nnubV3mxHeFH3Twa0d6Xg7376DGUb-10S67nDWpYqQVPhkFoohospOEVgKBVxNIj9aIqAicE4Tag0sEBS17fwDMvDdO:1spqAF:dqCCafryAO7PswFxjMX9B_FbFxSXdAeyHXO-r3p5BpY','2024-09-29 14:23:47.567424');
INSERT INTO "django_session" VALUES ('7q3bdrokssv5o0tvqal8wtzhktqs1caj','.eJxVjMsOwiAQRf-FtSEMlJdL934DAWaQqoGktCvjv2uTLnR7zzn3xULc1hq2QUuYkZ3ZxE6_W4r5QW0HeI_t1nnubV3mxHeFH3Twa0d6Xg7376DGUb-10S67nDWpYqQVPhkFoohospOEVgKBVxNIj9aIqAicE4Tag0sEBS17fwDMvDdO:1spqD7:wZlcLjgdVHrHX9ocXRc6NcQhahiExfrUk4HIsZ_xdXo','2024-09-29 14:26:45.965509');
INSERT INTO "django_session" VALUES ('gyakx3tb662ev69buhftwvlaquoxffm6','.eJxVjMsOwiAQRf-FtSEMlJdL934DAWaQqoGktCvjv2uTLnR7zzn3xULc1hq2QUuYkZ3ZxE6_W4r5QW0HeI_t1nnubV3mxHeFH3Twa0d6Xg7376DGUb-10S67nDWpYqQVPhkFoohospOEVgKBVxNIj9aIqAicE4Tag0sEBS17fwDMvDdO:1spqdO:ZpVH0GALgM7tQCimr3IhszjEClRhHQd_9BPVeirspyE','2024-09-29 14:53:54.640828');
INSERT INTO "django_session" VALUES ('ge9xdk7kl1b8emar6t6bqjgfl5kregxp','.eJxVjMsOwiAQRf-FtSEMlJdL934DAWaQqoGktCvjv2uTLnR7zzn3xULc1hq2QUuYkZ3ZxE6_W4r5QW0HeI_t1nnubV3mxHeFH3Twa0d6Xg7376DGUb-10S67nDWpYqQVPhkFoohospOEVgKBVxNIj9aIqAicE4Tag0sEBS17fwDMvDdO:1spqeZ:rM3u62lKJMilKnjV0sYSOk1AARBfvL9u2QXlX8qVfwc','2024-09-29 14:55:07.925983');
INSERT INTO "django_session" VALUES ('mcammvt2v1qdtetcdmd47ofedatef1rx','.eJxVjEEOwiAQRe_C2pDC4AAu3XsGMsygVA1NSrsy3l2bdKHb_977L5VoXWpae5nTKOqkjDr8bpn4UdoG5E7tNmme2jKPWW-K3mnXl0nK87y7fweVev3WbKwHC1DswCjoJXImFyQghujBmSgeMF7JZ2uQIhAOUhzK0UUCy-r9AcNpNyI:1spsyk:jLqPT2Jp0HDwXFOvNIQPsDw4ylKdlk6BprHiUw18AUo','2024-09-29 17:24:06.419565');
INSERT INTO "django_session" VALUES ('bdh8r78iitd8urh2z03ecjtnkazhcoq7','.eJxVjEEOwiAQRe_C2pDC4AAu3XsGMsygVA1NSrsy3l2bdKHb_977L5VoXWpae5nTKOqkjDr8bpn4UdoG5E7tNmme2jKPWW-K3mnXl0nK87y7fweVev3WbKwHC1DswCjoJXImFyQghujBmSgeMF7JZ2uQIhAOUhzK0UUCy-r9AcNpNyI:1sq572:BEJrgLKyHV0ajhZuslyjK1nf0A9uf-HWZq7sENn4GZc','2024-09-30 06:21:28.915149');
INSERT INTO "django_session" VALUES ('005wsba8gyvb95nvvvm3o6q6tmqkeerq','.eJxVjDsOQiEQAO9CbQgin8XS3jOQZRfkqYHkfSrj3ZXkFdrOTOYlIm5rjduS5zixOAsvDr8sIT1yG4Lv2G5dUm_rPCU5ErnbRV475-dlb_8GFZc6tmxAgYNsQaOjAC4BBF806y9E0uQsnUArQ47ZFHUkbZMPziJCMSzeH86cN5s:1sq5B0:fk3DNsbkak-Qkh6FZ88uLw19okdVOScUdXFCFktAnCc','2024-09-30 06:25:34.834761');
INSERT INTO "django_session" VALUES ('g6fdl2sovy4htvow1r4k9s172hkb7uyy','.eJxVjMsOwiAQRf-FtSEMlJdL934DAWaQqoGktCvjv2uTLnR7zzn3xULc1hq2QUuYkZ3ZxE6_W4r5QW0HeI_t1nnubV3mxHeFH3Twa0d6Xg7376DGUb-10S67nDWpYqQVPhkFoohospOEVgKBVxNIj9aIqAicE4Tag0sEBS17fwDMvDdO:1sq5BJ:vJTsMhGaFQ6BNQXpor0qbYH9I8jE_Krg5i1F2z5fiYo','2024-09-30 06:25:53.873954');
INSERT INTO "django_session" VALUES ('g7r6onaqp62vboqy3genbwahkgo2sbsc','.eJxVjEEOwiAQRe_C2pDC4AAu3XsGMsygVA1NSrsy3l2bdKHb_977L5VoXWpae5nTKOqkjDr8bpn4UdoG5E7tNmme2jKPWW-K3mnXl0nK87y7fweVev3WbKwHC1DswCjoJXImFyQghujBmSgeMF7JZ2uQIhAOUhzK0UUCy-r9AcNpNyI:1sqB1o:WE1DXv9GBEBXNzD6HjAWUQ9QLKNLTcg-FhPDmacb8hs','2024-09-30 12:40:28.706333');
INSERT INTO "django_session" VALUES ('otkleyri19i9aw2e0cpa7530pl8igmti','.eJxVjEEOwiAQRe_C2hBQCqNL956BDDODVE1JSrsy3l2adKHb997_bxVxXUpcm8xxZHVR1qjDL0xIT5k2ww-c7lVTnZZ5THpL9G6bvlWW13Vv_w4KttLXJ8gWxZgjcQiGyCEIAlNOiT12lw34s8sDJCCXfaciIXQvAf1g1ecLPSk5ug:1sqCtl:WkbodvZrTJRF3OfYsblpcsGo5pRy9MKgmQoABpkxRA8','2024-09-30 14:40:17.308038');
INSERT INTO "django_session" VALUES ('airzf2extjwu1insr68vwdo6yz2hlqvw','.eJxVjDsOwjAQBe_iGln2YjsxJT1niPYHCSBbipMKcXeIlALaNzPvZQZcl3FYm87DJOZkenP43Qj5oWUDcsdyq5ZrWeaJ7KbYnTZ7qaLP8-7-HYzYxm9NmDsOAolSdASOifiKPSl6J6Caos9H5QwQu-hYfUheYgcRgghLb94fBHY4Uw:1sqG8v:23Q_KpAA9c6nj8isOi5pSC7TxcmMcJeWLdlDd05vSYo','2024-09-30 18:08:09.070403');
INSERT INTO "django_session" VALUES ('84zlnuyob52bf048rxjsgyi0tul38un5','.eJxVjEEOwiAQRe_C2pCCwIBL9z0DGWZAqoYmpV0Z765NutDtf-_9l4i4rTVuPS9xYnERQZx-t4T0yG0HfMd2myXNbV2mJHdFHrTLceb8vB7u30HFXr-1KYF1AXQ6DSEp9AocsoPBFG2CJyJOYJlJuzOAtaRLYSo-gFZBZRLvD_H8OFA:1sqY3k:J-ali-hHpJoBtHTmy0GC-k_fdqJN910gDI_F1cQedYQ','2024-10-01 13:16:00.138103');
INSERT INTO "django_session" VALUES ('gb9q9sq9xmrvvq07khsawfc8tv7brnpj','.eJxVjEEOwiAQRe_C2pDC4AAu3XsGMsygVA1NSrsy3l2bdKHb_977L5VoXWpae5nTKOqkjDr8bpn4UdoG5E7tNmme2jKPWW-K3mnXl0nK87y7fweVev3WbKwHC1DswCjoJXImFyQghujBmSgeMF7JZ2uQIhAOUhzK0UUCy-r9AcNpNyI:1sqYmF:TqSO9MUc8JhTCTIEuCzExxJH6ahuSviQM1oNQiqwWpA','2024-10-01 14:01:59.273915');
INSERT INTO "django_session" VALUES ('g1g6431g7czpuh3skm5xusjdknbtqrth','.eJxVjDsOwjAQBe_iGln2YjsxJT1niPYHCSBbipMKcXeIlALaNzPvZQZcl3FYm87DJOZkenP43Qj5oWUDcsdyq5ZrWeaJ7KbYnTZ7qaLP8-7-HYzYxm9NmDsOAolSdASOifiKPSl6J6Caos9H5QwQu-hYfUheYgcRgghLb94fBHY4Uw:1sqYnE:8mwV3hpCwug4HLBj4uggUMACrZJpmdsWZCxcHCHlVag','2024-10-01 14:03:00.520876');
INSERT INTO "django_session" VALUES ('tiv8a4cdheh3tts0g3b2cya0rkhe47qj','.eJxVjDsOwjAQBe_iGln2YjsxJT1niPYHCSBbipMKcXeIlALaNzPvZQZcl3FYm87DJOZkenP43Qj5oWUDcsdyq5ZrWeaJ7KbYnTZ7qaLP8-7-HYzYxm9NmDsOAolSdASOifiKPSl6J6Caos9H5QwQu-hYfUheYgcRgghLb94fBHY4Uw:1sqbnA:2ZXy4q6EzE3abUb1wKuRh-e-ClmYcH_xdBSEBd29h34','2024-10-01 17:15:08.765421');
INSERT INTO "django_session" VALUES ('f1rpo4rdi29nklwn57vs0jd6tqk4efer','.eJxVjDsOwjAQBe_iGln2YjsxJT1niPYHCSBbipMKcXeIlALaNzPvZQZcl3FYm87DJOZkenP43Qj5oWUDcsdyq5ZrWeaJ7KbYnTZ7qaLP8-7-HYzYxm9NmDsOAolSdASOifiKPSl6J6Caos9H5QwQu-hYfUheYgcRgghLb94fBHY4Uw:1sqwUw:0SkNXru2yonB22NO9NXhR2OOVjtd3ilBzAwZ04_pRN4','2024-10-02 15:21:42.504847');
INSERT INTO "django_session" VALUES ('z0s6g7basaxe1zs5dyk122gzmwxk6jgg','.eJxVjDsOwjAQBe_iGln2YjsxJT1niPYHCSBbipMKcXeIlALaNzPvZQZcl3FYm87DJOZkenP43Qj5oWUDcsdyq5ZrWeaJ7KbYnTZ7qaLP8-7-HYzYxm9NmDsOAolSdASOifiKPSl6J6Caos9H5QwQu-hYfUheYgcRgghLb94fBHY4Uw:1sqxSo:FUBZmtpWk1fNVjbIhupmZTfqcc6XkfhUmRZtw_iHUCY','2024-10-02 16:23:34.147616');
INSERT INTO "django_session" VALUES ('z7zgqyyqswy7ouu6w3slxpngj9ymx2lb','.eJxVjEEOwiAQRe_C2pCCwIBL9z0DGWZAqoYmpV0Z765NutDtf-_9l4i4rTVuPS9xYnERQZx-t4T0yG0HfMd2myXNbV2mJHdFHrTLceb8vB7u30HFXr-1KYF1AXQ6DSEp9AocsoPBFG2CJyJOYJlJuzOAtaRLYSo-gFZBZRLvD_H8OFA:1sqxZl:MfNSUGvwJb4Ad7iZHsBPMpBoTnMiuxIoomWtt3j5fXY','2024-10-02 16:30:45.443095');
INSERT INTO "django_session" VALUES ('whku5ng1c33911y5ie6pzqmqdd5f3awg','.eJxVjEEOwiAQRe_C2pCCwIBL9z0DGWZAqoYmpV0Z765NutDtf-_9l4i4rTVuPS9xYnERQZx-t4T0yG0HfMd2myXNbV2mJHdFHrTLceb8vB7u30HFXr-1KYF1AXQ6DSEp9AocsoPBFG2CJyJOYJlJuzOAtaRLYSo-gFZBZRLvD_H8OFA:1sqxc5:28C78XiCBG9ncve-NL-J6HylUmQ9_DlOOuqzggj2m_E','2024-10-02 16:33:09.943479');
INSERT INTO "django_session" VALUES ('ckuxbmigcpws6t8s37ih4ut3r04ka0p8','.eJxVjEEOwiAQRe_C2pCCwIBL9z0DGWZAqoYmpV0Z765NutDtf-_9l4i4rTVuPS9xYnERQZx-t4T0yG0HfMd2myXNbV2mJHdFHrTLceb8vB7u30HFXr-1KYF1AXQ6DSEp9AocsoPBFG2CJyJOYJlJuzOAtaRLYSo-gFZBZRLvD_H8OFA:1srAZ9:9WMik9ZMa-ODPtwGnTi9B6Qcb8MyRSh_i0Z4GugUIa0','2024-10-03 06:22:59.297751');
INSERT INTO "django_session" VALUES ('vmxdrnn5t846wq7s9ijysaee33mv0f73','.eJxVjDsOwjAQBe_iGln2YjsxJT1niPYHCSBbipMKcXeIlALaNzPvZQZcl3FYm87DJOZkenP43Qj5oWUDcsdyq5ZrWeaJ7KbYnTZ7qaLP8-7-HYzYxm9NmDsOAolSdASOifiKPSl6J6Caos9H5QwQu-hYfUheYgcRgghLb94fBHY4Uw:1srCHi:WmUfuqSzzIiwBww93tZSzc89jcpNPt0e5u8KwfNLjFA','2024-10-03 08:13:06.723232');
INSERT INTO "django_session" VALUES ('5z9q5qg9re99zjujvslyc0xb94yz0twg','.eJxVjDsOwjAQBe_iGln2YjsxJT1niPYHCSBbipMKcXeIlALaNzPvZQZcl3FYm87DJOZkenP43Qj5oWUDcsdyq5ZrWeaJ7KbYnTZ7qaLP8-7-HYzYxm9NmDsOAolSdASOifiKPSl6J6Caos9H5QwQu-hYfUheYgcRgghLb94fBHY4Uw:1srCI0:83UZmFgPdwKacSRQtSia4meFpJ_uyMeEeQt6uo0fJH4','2024-10-03 08:13:24.952958');
INSERT INTO "django_session" VALUES ('v93g1mrgv4qjjse3budun9oqxqksyrrd','.eJxVjEEOwiAQRe_C2pCCwIBL9z0DGWZAqoYmpV0Z765NutDtf-_9l4i4rTVuPS9xYnERQZx-t4T0yG0HfMd2myXNbV2mJHdFHrTLceb8vB7u30HFXr-1KYF1AXQ6DSEp9AocsoPBFG2CJyJOYJlJuzOAtaRLYSo-gFZBZRLvD_H8OFA:1srCdR:djbaVpiEa1bz8P_qy6J2Do-vq7y94uq1NyFBwsOX8y4','2024-10-03 08:35:33.345053');
INSERT INTO "django_session" VALUES ('qff9ljnpoegyayiweg83xd7ggdjywp57','.eJxVjDsOwjAQBe_iGln2YjsxJT1niPYHCSBbipMKcXeIlALaNzPvZQZcl3FYm87DJOZkenP43Qj5oWUDcsdyq5ZrWeaJ7KbYnTZ7qaLP8-7-HYzYxm9NmDsOAolSdASOifiKPSl6J6Caos9H5QwQu-hYfUheYgcRgghLb94fBHY4Uw:1srCiP:2g9iiGyfID2icTLUPxESG_dxWpkgDAfPTNvmykhdnx0','2024-10-03 08:40:41.704016');
INSERT INTO "django_session" VALUES ('53qqgz2fvv80ygo3vuta0feo1e1otrjv','.eJxVjEEOwiAQRe_C2pCCwIBL9z0DGWZAqoYmpV0Z765NutDtf-_9l4i4rTVuPS9xYnERQZx-t4T0yG0HfMd2myXNbV2mJHdFHrTLceb8vB7u30HFXr-1KYF1AXQ6DSEp9AocsoPBFG2CJyJOYJlJuzOAtaRLYSo-gFZBZRLvD_H8OFA:1srCiZ:NaeIFUHRMlnLTlfYaIKq5_f6B47PiJadx7JvRQ-SWbg','2024-10-03 08:40:51.252536');
INSERT INTO "django_session" VALUES ('xx0scvsghfxtu4nm919kp7gyi7ecg8dn','.eJxVjEEOwiAQRe_C2pCCwIBL9z0DGWZAqoYmpV0Z765NutDtf-_9l4i4rTVuPS9xYnERQZx-t4T0yG0HfMd2myXNbV2mJHdFHrTLceb8vB7u30HFXr-1KYF1AXQ6DSEp9AocsoPBFG2CJyJOYJlJuzOAtaRLYSo-gFZBZRLvD_H8OFA:1srCjR:abfrv8jDZIt1buhXwYBIJJ5c-B5QcCu_UANrBS8cAFg','2024-10-03 08:41:45.757401');
INSERT INTO "django_session" VALUES ('x0b9wgekj3snh9n2zruaurp7cp9bw7qw','.eJxVjEEOwiAQRe_C2pDC4AAu3XsGMsygVA1NSrsy3l2bdKHb_977L5VoXWpae5nTKOqkjDr8bpn4UdoG5E7tNmme2jKPWW-K3mnXl0nK87y7fweVev3WbKwHC1DswCjoJXImFyQghujBmSgeMF7JZ2uQIhAOUhzK0UUCy-r9AcNpNyI:1srGiS:fwF6GgfCNt2v2UONlqTMQOztR7KMRvU6Mwx1WKzUBgU','2024-10-03 12:57:00.852204');
INSERT INTO "django_session" VALUES ('g64p5vs8jmz67n53rc3bbq0kub2aenl1','.eJxVjEEOwiAQRe_C2pCCwIBL9z0DGWZAqoYmpV0Z765NutDtf-_9l4i4rTVuPS9xYnERQZx-t4T0yG0HfMd2myXNbV2mJHdFHrTLceb8vB7u30HFXr-1KYF1AXQ6DSEp9AocsoPBFG2CJyJOYJlJuzOAtaRLYSo-gFZBZRLvD_H8OFA:1srH3Y:O2w9dDM3BuK0xGYKI2Z6EiYRwDWJtOoHTkCFe2alLOg','2024-10-03 13:18:48.082076');
INSERT INTO "django_session" VALUES ('bhhbtgp49e1y03nvskcxz3egcs4rwqj2','.eJxVjDsOwjAQBe_iGln2YjsxJT1niPYHCSBbipMKcXeIlALaNzPvZQZcl3FYm87DJOZkenP43Qj5oWUDcsdyq5ZrWeaJ7KbYnTZ7qaLP8-7-HYzYxm9NmDsOAolSdASOifiKPSl6J6Caos9H5QwQu-hYfUheYgcRgghLb94fBHY4Uw:1srH3e:WlIH-U5Bd9xhK5WjNvPmJ6LYNfbegpTDQ4RIP_BZCxU','2024-10-03 13:18:54.215875');
INSERT INTO "django_session" VALUES ('z00wqfszqm441h7ry9kqflhej7nq88vo','.eJxVjEEOwiAQRe_C2pCCwIBL9z0DGWZAqoYmpV0Z765NutDtf-_9l4i4rTVuPS9xYnERQZx-t4T0yG0HfMd2myXNbV2mJHdFHrTLceb8vB7u30HFXr-1KYF1AXQ6DSEp9AocsoPBFG2CJyJOYJlJuzOAtaRLYSo-gFZBZRLvD_H8OFA:1srH3p:0w60W7FJjwV1vz2LDBPY7uDGLhZyaYf0BRmElkrZbzg','2024-10-03 13:19:05.480618');
INSERT INTO "django_session" VALUES ('d906gurzl1x6tlzba18f5of3a1y1k7nu','.eJxVjEEOwiAQRe_C2pCCwIBL9z0DGWZAqoYmpV0Z765NutDtf-_9l4i4rTVuPS9xYnERQZx-t4T0yG0HfMd2myXNbV2mJHdFHrTLceb8vB7u30HFXr-1KYF1AXQ6DSEp9AocsoPBFG2CJyJOYJlJuzOAtaRLYSo-gFZBZRLvD_H8OFA:1srHLJ:LkgId25kVpMERIpsAeKGUse6J7OMccxszdHuhlsnxLc','2024-10-03 13:37:09.317022');
INSERT INTO "django_session" VALUES ('4fhjl09dhenj13f0fvt1fg5l3ifzzh6s','.eJxVjDsOwjAQBe_iGln2YjsxJT1niPYHCSBbipMKcXeIlALaNzPvZQZcl3FYm87DJOZkenP43Qj5oWUDcsdyq5ZrWeaJ7KbYnTZ7qaLP8-7-HYzYxm9NmDsOAolSdASOifiKPSl6J6Caos9H5QwQu-hYfUheYgcRgghLb94fBHY4Uw:1srHLQ:itTlgrkQfFF-C07Ed5e0xa_PdWb58nQNUHMpMAG3p6w','2024-10-03 13:37:16.749291');
INSERT INTO "django_session" VALUES ('y3dho2ske7ci5mzscpckwdj5ey5m0096','.eJxVjDsOwjAQBe_iGln2YjsxJT1niPYHCSBbipMKcXeIlALaNzPvZQZcl3FYm87DJOZkenP43Qj5oWUDcsdyq5ZrWeaJ7KbYnTZ7qaLP8-7-HYzYxm9NmDsOAolSdASOifiKPSl6J6Caos9H5QwQu-hYfUheYgcRgghLb94fBHY4Uw:1srHLe:0H4dGP29bYa1sm58Sca7XFq1xiaaLvHGRgMtVQAJ2Gk','2024-10-03 13:37:30.171845');
INSERT INTO "django_session" VALUES ('q0zt8k94j7h5777ups019o9zgr9hyk0f','.eJxVjEEOwiAQRe_C2pCCwIBL9z0DGWZAqoYmpV0Z765NutDtf-_9l4i4rTVuPS9xYnERQZx-t4T0yG0HfMd2myXNbV2mJHdFHrTLceb8vB7u30HFXr-1KYF1AXQ6DSEp9AocsoPBFG2CJyJOYJlJuzOAtaRLYSo-gFZBZRLvD_H8OFA:1srHLw:Q0YCCVsXVoH6Kfb77n3xieGaCwSfyvfcFfH-DmxWYMU','2024-10-03 13:37:48.935842');
INSERT INTO "django_session" VALUES ('jt56nx1h4yrlm2b922iqn63m6z2cgvy4','.eJxVjDsOwjAQBe_iGln2YjsxJT1niPYHCSBbipMKcXeIlALaNzPvZQZcl3FYm87DJOZkenP43Qj5oWUDcsdyq5ZrWeaJ7KbYnTZ7qaLP8-7-HYzYxm9NmDsOAolSdASOifiKPSl6J6Caos9H5QwQu-hYfUheYgcRgghLb94fBHY4Uw:1srHNi:3mBKxZ8AwIFgKUpaiXPVGd-CASKP5befpSlXJjnQMZA','2024-10-03 13:39:38.184185');
INSERT INTO "django_session" VALUES ('bnwg6wr3r6cz78vbrvzqh2g140fphaik','.eJxVjEEOwiAQRe_C2pCCwIBL9z0DGWZAqoYmpV0Z765NutDtf-_9l4i4rTVuPS9xYnERQZx-t4T0yG0HfMd2myXNbV2mJHdFHrTLceb8vB7u30HFXr-1KYF1AXQ6DSEp9AocsoPBFG2CJyJOYJlJuzOAtaRLYSo-gFZBZRLvD_H8OFA:1srHNq:fPpjU3S88RWNKPvKX0MC9A1JCp7DgtE7FxgVuVuKp9M','2024-10-03 13:39:46.250764');
INSERT INTO "django_session" VALUES ('176nen107rtiqzlb8oy9uaesqw1crf33','.eJxVjEEOwiAQRe_C2pCCwIBL9z0DGWZAqoYmpV0Z765NutDtf-_9l4i4rTVuPS9xYnERQZx-t4T0yG0HfMd2myXNbV2mJHdFHrTLceb8vB7u30HFXr-1KYF1AXQ6DSEp9AocsoPBFG2CJyJOYJlJuzOAtaRLYSo-gFZBZRLvD_H8OFA:1srHQG:ks8vw9CdExCeyeRfq3AaJCvdQSvOwGndEfbdoTaiFUU','2024-10-03 13:42:16.933953');
INSERT INTO "django_session" VALUES ('mgbgo7phygt678c5kriitt9r1dm68uj4','.eJxVjDsOwjAQBe_iGln2YjsxJT1niPYHCSBbipMKcXeIlALaNzPvZQZcl3FYm87DJOZkenP43Qj5oWUDcsdyq5ZrWeaJ7KbYnTZ7qaLP8-7-HYzYxm9NmDsOAolSdASOifiKPSl6J6Caos9H5QwQu-hYfUheYgcRgghLb94fBHY4Uw:1srHUi:n_0outEpNvyu_3mQlBA6ROo1akfbPxFPeB_hNPjb2iU','2024-10-03 13:46:52.908343');
INSERT INTO "django_session" VALUES ('psbnluqjbwvpxsnqltbqd374b9oyalo9','.eJxVjEEOwiAQRe_C2pCCwIBL9z0DGWZAqoYmpV0Z765NutDtf-_9l4i4rTVuPS9xYnERQZx-t4T0yG0HfMd2myXNbV2mJHdFHrTLceb8vB7u30HFXr-1KYF1AXQ6DSEp9AocsoPBFG2CJyJOYJlJuzOAtaRLYSo-gFZBZRLvD_H8OFA:1srHUt:kg7yY9rWzqeRfcUcvOZti6K5Mj02OqtKInjrhq2b3gA','2024-10-03 13:47:03.173158');
INSERT INTO "django_session" VALUES ('q0mtissynat83eo07u6l7rokkrt8exea','.eJxVjEEOwiAQRe_C2pCCwIBL9z0DGWZAqoYmpV0Z765NutDtf-_9l4i4rTVuPS9xYnERQZx-t4T0yG0HfMd2myXNbV2mJHdFHrTLceb8vB7u30HFXr-1KYF1AXQ6DSEp9AocsoPBFG2CJyJOYJlJuzOAtaRLYSo-gFZBZRLvD_H8OFA:1srHlr:xfwZLGXFDAaGF9Fc2Ybw-TPTDpcwqK0f38HeCNuByqo','2024-10-03 14:04:35.791068');
INSERT INTO "django_session" VALUES ('phtz5rmvgfgxderpdkv9bun5sjpxa5ld','.eJxVjDsOwjAQBe_iGln2YjsxJT1niPYHCSBbipMKcXeIlALaNzPvZQZcl3FYm87DJOZkenP43Qj5oWUDcsdyq5ZrWeaJ7KbYnTZ7qaLP8-7-HYzYxm9NmDsOAolSdASOifiKPSl6J6Caos9H5QwQu-hYfUheYgcRgghLb94fBHY4Uw:1srHly:vqI1VIT58-Hy6rSuCQZUoHHs9H-Qrn94KatLX5MGohg','2024-10-03 14:04:42.659010');
INSERT INTO "django_session" VALUES ('zs0twz7hvb67f9dvztjokthn0kqhz3k6','.eJxVjEEOwiAQRe_C2pCCwIBL9z0DGWZAqoYmpV0Z765NutDtf-_9l4i4rTVuPS9xYnERQZx-t4T0yG0HfMd2myXNbV2mJHdFHrTLceb8vB7u30HFXr-1KYF1AXQ6DSEp9AocsoPBFG2CJyJOYJlJuzOAtaRLYSo-gFZBZRLvD_H8OFA:1srHmD:t_xx3XBPUsRKfbIKi5ackebvQr6CBsGSfQ_VNEEYnJI','2024-10-03 14:04:57.146609');
INSERT INTO "django_session" VALUES ('mh2m2uayqqgm0d7u4fx1dh3d1rvr2m19','.eJxVjDsOwjAQBe_iGln2YjsxJT1niPYHCSBbipMKcXeIlALaNzPvZQZcl3FYm87DJOZkenP43Qj5oWUDcsdyq5ZrWeaJ7KbYnTZ7qaLP8-7-HYzYxm9NmDsOAolSdASOifiKPSl6J6Caos9H5QwQu-hYfUheYgcRgghLb94fBHY4Uw:1srISu:3pejd8Rz_OPWbBcoNWDxT2Gz9LYh2hdaZ6GT185d9f8','2024-10-03 14:49:04.248126');
INSERT INTO "django_session" VALUES ('rwcg92x4hc9hb3kj5y74wmfvbkbvrie1','.eJxVjEEOwiAQRe_C2pCCwIBL9z0DGWZAqoYmpV0Z765NutDtf-_9l4i4rTVuPS9xYnERQZx-t4T0yG0HfMd2myXNbV2mJHdFHrTLceb8vB7u30HFXr-1KYF1AXQ6DSEp9AocsoPBFG2CJyJOYJlJuzOAtaRLYSo-gFZBZRLvD_H8OFA:1srITZ:BWhAwNpegLGoYO1gXPHlyITPQy27wifzfKKyC392Nb4','2024-10-03 14:49:45.198052');
INSERT INTO "django_session" VALUES ('8y84xn0lsz6zrcbv1hjry0a42hk4osge','.eJxVjEEOwiAQRe_C2pCCwIBL9z0DGWZAqoYmpV0Z765NutDtf-_9l4i4rTVuPS9xYnERQZx-t4T0yG0HfMd2myXNbV2mJHdFHrTLceb8vB7u30HFXr-1KYF1AXQ6DSEp9AocsoPBFG2CJyJOYJlJuzOAtaRLYSo-gFZBZRLvD_H8OFA:1srIZx:xuazLIWBDnf--prfM70R8myUk46vsFTDopnNNI2obIs','2024-10-03 14:56:21.112023');
INSERT INTO "django_session" VALUES ('yxcsmn6nz5ztkp3b2p66sg5q9z5szz20','.eJxVjDsOwjAQBe_iGln2YjsxJT1niPYHCSBbipMKcXeIlALaNzPvZQZcl3FYm87DJOZkenP43Qj5oWUDcsdyq5ZrWeaJ7KbYnTZ7qaLP8-7-HYzYxm9NmDsOAolSdASOifiKPSl6J6Caos9H5QwQu-hYfUheYgcRgghLb94fBHY4Uw:1srIau:vFrOHtGS_x8ZnvQQZDFq_j1YgKvMeW5fw5TV2psAe_g','2024-10-03 14:57:20.228660');
INSERT INTO "django_session" VALUES ('a6cst02dyxpfseu9250duyibiupbl7zg','.eJxVjDsOwjAQBe_iGln2YjsxJT1niPYHCSBbipMKcXeIlALaNzPvZQZcl3FYm87DJOZkenP43Qj5oWUDcsdyq5ZrWeaJ7KbYnTZ7qaLP8-7-HYzYxm9NmDsOAolSdASOifiKPSl6J6Caos9H5QwQu-hYfUheYgcRgghLb94fBHY4Uw:1srIb3:zeTtaGQNTMZ9uvJ5Pjv0Ke_j9emLpo9URPSsS-qBiPA','2024-10-03 14:57:29.888228');
INSERT INTO "users_useraccount" VALUES (3,'','customer',4);
INSERT INTO "users_useraccount" VALUES (7,'01914639597','seller',9);
INSERT INTO "users_useraccount" VALUES (8,'01914639597','customer',8);
INSERT INTO "users_useraccount" VALUES (9,'','seller',10);
INSERT INTO "users_useraccount" VALUES (10,'01914639597','seller',11);
INSERT INTO "products_product" VALUES (6,'mann One Men''s Sonic The Hedgehog Cap, Embroidered Logo Baseball Hat with Flat Brim, Adjustable','THE HEDGEHOG BASEBALL CAP: Royal blue flat bill adjustable snapback hat for adults featuring a running Sonic the Hedgehog running on the front of the cap, and his friends Tails and Knuckles embroidered on the sides
ONE SIZE FITS ALL: Ball cap features an adjustable snapback closure on the back of the cap to allow for easy resizing for a snug and comfortable fit on adult men and women''s heads of all shapes and sizes
LIGHTWEIGHT AND DURABLE: Adjustable hat is composed of lightweight and durable faux wool polyester fabric to allow for instant comfort when worn, and features a flat hat bill with stitching to keep sun light out of your eyes
OFFICIALLY LICENSED: These baseball hats are officially licensed Sega products, ensuring that you are receiving quality Sonic the Hedgehog soft caps
HAND WASH ONLY: Caps are recommended for hand washing only, lay flat to dry, do not iron',25,20,'product_images/81pD6339y0L._AC_SX569_.jpg','#HDIO79DL',5,7);
INSERT INTO "products_product" VALUES (7,'Nikon COOLPIX P950 16MP 83x Super Telephoto Zoom Digital Camera 4K UHD - (Renewed)','This Certified Refurbished product is manufacturer refurbished it shows limited or no wear

Includes all original accessories plus a 90 day warranty

Nikon COOLPIX P950 16MP 83x Super Telephoto Zoom Digital Camera 4K UHD

16 MP Low-light CMOS Sensor | 83x Zoom-NIKKOR ED Glass Lens | 3.2" 921,000-dot Vari-Angle LCD | VR image stabilization | ISO 6400 | Target Finding AF | Wi-Fi | Subject Tracking | Smart Portrait System

INCLUDED IN THE BOX: Nikon COOLPIX P950 Black | EN-EL20a Rechargeable Li-ion Battery | EH-73P Charging AC Adapter | UC-E21 USB Cable | AN-DC3 Strap | LC-67 67mm Snap-On Lens Cap | HN-CP20 Lens Hood | Nikon USA Authorized Refurbished 90-Day Warranty',700,600,'product_images/71iKNJ6rVIL._AC_SX466__FISeeQs.jpg','#HDI379DSD',4,7);
INSERT INTO "products_product" VALUES (9,'Realme GT Master Edition - Official smartphone','Keep Curious, Keep Exploring- Realme GT Master edition is designed with this slogan by Naoto Fukasawa. (A famous industrial designer and explorer). The designer tries to connect with life and the design is inspired by a suitcase that is an essential part of exploration.



Beside this exceptional design the phone is flourished with Mastery features that takes the phone to a level of Masterpiece.



Suitcase Design

Street Photography mode

Samsung AMOLED Display

Powerful Snapdragon Processor

65W SuperDart Charge

Virtual RAM extension',349,300,'product_images/3570-65733.jpg','#HO79DSD',2,7);
INSERT INTO "products_product" VALUES (17,'Champion Men''S Classic T-Shirt, Everyday Tee For Men, Comfortable Soft Men''S T-Shirt','THE FIT - Standard-fit men''s T-shirt for a classic look.

THE FEEL - Crafted from a soft, 5.5 oz. cotton or cotton blend.

THE LOOK - Classic short-sleeve style with ribbed crew neckline and soft back neck tape.

SPOT THE C - Iconic C logo at the chest and left sleeve are recognizable on and off the field.

Note: C logo patch color may vary from image.',100,50,'product_images/tshirt1_7MDu5iG.jpg','#HDIO79D',1,9);
INSERT INTO "products_product" VALUES (18,'Gildan Men''s Crew T-Shirts, Multipack, Style G1100, Navy/Charcoal/Cardinal Red (5-Pack), X-Large Gildan Men''s Crew T-Shirts,','VALUE YOU EXPECT – Stock up with a 6-pack of assorted colors.

SIZE OPTIONS – From men''s shirt sizes Small-3XL, our multiple size options make shopping simple. Are oversized T-shirts your thing? Order a size up!

TAGLESS, TOO – Because who has time for scratchy tags?

EASY CARE – Throw your 100% cotton tees right in the washing machine on laundry day.',100,50,'product_images/61ECvCbRZeL._AC_SX679__hTr6g2u.jpg','#HDIO79DFG',3,9);
INSERT INTO "products_product" VALUES (19,'ASUS TUF Gaming 32" 1440P HDR Curved Monitor (VG32VQ1B) - QHD (2560 x 1440), 165Hz (Supports 144Hz), 1ms, Extreme Low Motion Blur, Speaker, FreeSync Premium, VESA Mountable, DisplayPort, HDMI,BLACK','31.5-inch WQHD (2560x1440) 1500R gaming monitor with ultrafast 165Hz refresh rate (supports 144Hz) designed for professional gamers and immersive gameplay

ASUS Extreme Low Motion Blur (ELMB ) technology enables a 1ms response time (MPRT) together with Adaptive-sync, eliminating ghosting and tearing for sharp gaming visuals with high frame rates

FreeSync Premium technology supported through DisplayPort and HDMI ports providing variable refresh rates for low latency, stuttering-free and tearing-free while gaming

Shadow Boost enhances image details in dark areas, brightening scenes without over-exposing bright areas

Supports HDR-10 to enhance bright and dark area, delivers lifelike gaming experience',299,251,'product_images/81GHk8mQXxL._AC_SX466_.jpg','#HDI9DLVSD',6,9);
INSERT INTO "products_product" VALUES (20,'SAMSUNG 32-Inch Odyssey OLED G8 (G80SD) Series 4K UHD Smart Gaming Monitor','EXPERIENCE A BRIGHTER WORLD: Content springs to life in 4K OLED; Brilliant imagery shines with 250 nits (typ) of brightness and a wider spectrum of colors, shades & contrasts; The NQ8 AI Gen3 Processor also upscales lower resolutions to nearly 4K

OUTMANEUVER OPPONENTS w/ SUPREME SPEED: Dodge, counter & engage faster with OLED technology, offering a near-instant 0.03ms response time (GtG); Stay ahead with HDMI 2.1 & DisplayPort connections & a 240Hz refresh rate in UHD resolution¹

DYNAMIC COOLING SYSTEM: For the 1st time ever, a Pulsating Heat Pipe was introduced into the monitor to prevent burn-in; The Dynamic Cooling System evaporates & condenses a coolant to diffuse heat 5x better than the older graphite sheet method²

THERMAL MODULATION SYSTEM: Algorithms predict surface temperature and automatically control brightness to reduce heat accordingly³

LOGO & TASKBAR DETECTION: The brightness on static images, like logos and taskbars, is automatically reduced to prevent burn-in⁴

SCREEN SAVER: The screen dims itself after 10 minutes of inactivity, and comes back to regular brightness with any input²

IMPROVED FOCUS, NO DISTRACTIONS: Glare Free technology significantly reduces glare from external light sources, so the OLED screen''s perfect black and color experience are presented without distractions⁵',299,251,'product_images/81TGdTuRZPL.__AC_SY300_SX300_QL70_FMwebp_.jpg','#HDI9DLVSDL',6,9);
INSERT INTO "products_product" VALUES (21,'ASUS ZenScreen 15.6” 1080P Portable Monitor (MB16ACV) - Full HD','15.6-inch Full HD portable anti-glare IPS display with an ultraslim and thin design, perfect solution for travel, on-the-go meetings, or business trips.Specific uses for product - Business

Kickstand design to prop the monitor up in either portrait or landscape mode easily

Features a hybrid-signal solution which supports power and video transmission, and enables compatibility with any laptop with a USB Type-C or Type A port

ASUS Eye Care monitors feature TÜV Rheinland-certified Flicker-free and Low Blue Light technologies to ensure a comfortable viewing experience

Tripod Hole compatible with standard 1/4 inch screw thread for universal tripods or clamp mount',299,251,'product_images/61prlzCQqlL.__AC_SX300_SY300_QL70_FMwebp_.jpg','#HDI9DLSDL',6,10);
INSERT INTO "products_product" VALUES (22,'MENS L/S SHIRT-PURPLE STRIPE clothes T-Shirts','Elevate your style with our MENS L/S SHIRT-PURPLE STRIPE. Made with a modern purple stripe design, this long sleeve shirt offers both comfort and sophistication. Perfect for any occasion, it''s a must-have in every man''s wardrobe. Upgrade your look today!',10,9,'product_images/0070000056475.jpg','#HDI9DLVSDf',1,9);
INSERT INTO "products_product" VALUES (23,'Blue Printed Viscose-Cotton Shirt','Blue viscose-cotton shirt with black and white prints. Features chest pocket.',10,9,'product_images/0070000055766_1.jpg','#HDIF9DLVSD',1,10);
INSERT INTO "products_product" VALUES (24,'Lenovo HD 1080p Webcam (300 FHD) - Monitor Camera with 95° Wide Angle, 360° Rotation Pan & Tilt, Dual Microphones – Attachable Desktop Cam with Privacy Shutter for Remote Work, Streaming & Gaming','Full HD 1080p Clarity: Experience crystal-clear video quality with the Lenovo 300 FHD Webcam, equipped with a high-resolution 2.1-megapixel CMOS camera that delivers stunning full HD 1080p resolution at 30fps for sharp and detailed visuals

Wide-Angle Lens: Capture a wider perspective with the 95-degree wide-angle lens, allowing you to fit more into the frame. Whether it''s video conferences, online streaming, or content creation, the wide-angle lens ensures a more immersive viewing experience

Convenient Plug-and-Play Connectivity: Set up your webcam in seconds, just plug the USB 2.0 cable into any Windows or Mac device; UVC encode ensures compatibility with a wide range of video conferencing software and operating systems

Flexible Tilt and Rotation: Adjust your webcam effortlessly to get the perfect angle. This highly adjustable webcam features tilt controls, and its 360-degrees rotation capability ensures you can capture every moment from any angle

Crystal Clear Audio: Enjoy superior audio quality with the integrated full-stereo dual microphones. Whether you''re in a meeting, recording a video, or on a long-distance video call, the 2 integrated mics deliver clear and crisp sound',10,9,'product_images/61t0xGVPzJL.__AC_SX300_SY300_QL70_FMwebp_.jpg','#HDIF9DLVSDd',7,7);
INSERT INTO "products_product" VALUES (25,'Insta360 Flow Smartphone Gimbal Stabilizer Creator Kit','3-Axis Stabilization for Smooth Footage

Magnetic Phone Clamp, Flow Spotlight

USB-C and Lightning Cables

Built-In Selfie Stick/Tripod, Carry Bag

Deep Track 3.0 AI Subject Tracking

Slow Motion, Zoom Tracking

Auto, Follow, Pan Follow FPV Modes',349,251,'product_images/61KdhiqL6L._AC_SX466__sK9WdNL.jpg','#PHIO79DLVSD',4,10);
INSERT INTO "products_product" VALUES (26,'Anker 332 USB-C Hub (5-in-1) with 4K HDMI Display,','5-in-1 Connectivity: Equipped with a 4K HDMI port, a 5 Gbps USB-C data port, two 5 Gbps USB-A ports, and a 100W PD-IN port.

Powerful Pass-Through Charging: Supports up to 85W pass-through charging so you can power up your laptop while you use the hub. Note: Pass-through charging requires a charger (not included). Note: To achieve full power for iPad, we recommend using a 45W wall charger.

Transfer Files in Seconds: Move files to and from your laptop at speeds of up to 5 Gbps via the USB-C and USB-A data ports.

HD Display: Connect to the HDMI port to stream or mirror content to an external monitor in resolutions of up to 4K@30Hz. Note: The USB-C ports do not support video output.

What You Get: Anker 332 USB-C Hub (5-in-1), welcome guide, our worry-free 18-month warranty, and friendly customer service.',349,251,'product_images/61LwkkogjrL._AC_SX679_.jpg','#PHI79DLVSD',7,10);
INSERT INTO "products_product" VALUES (30,'Flexible And Comfortable Stylish Complete Black Sunglasses','Comfortable',25,20,'product_images/6b26bee15207874b8c85c799679ea3a0.jpg_720x720q80.jpg__rpl3wEP.jpg','DKS0469r',10,7);
INSERT INTO "products_product" VALUES (31,'Richman Men’s fashion   Jeans Mid Indigo Color Denim Pant','Code: A583410



Color: Dark Indigo



Washing care : Cold wash, low dry, no bleach.



Slim-fit jeans. Five pockets. Faded effect. Zip fly and button fastening on the front',40,29.99,'product_images/pant_tQb52ZF.jpg','DS04694',8,7);
INSERT INTO "products_product" VALUES (32,'New Fashion Casual Men Shoes Fashion','Product detais:Fashionable men''s shoes for summer and autumn.• Slip-on design with buckle closure for easy wear.• Pointed toe and low heel for a sleek look.• Made of high-quality artificial leather.• Perfect for business and formal occastion',300,200,'product_images/shoe_img1_dV90ApC.jpg','DS046947',11,9);
INSERT INTO "products_product" VALUES (33,'NAVIFORCE Man''s Casual Wild Quartz Wristwatch Waterproof Stainless Steel Watches for Men','Model: NAVIFORCE NF9204S



Movement: Quartz Calendar Movement



Gender:Men & Male



Style: Fashion & Casual & Sport & Business



Dial Window Material Type: Hardened Mineral Glass



Band Material Type: Stainless Steel Strap



Clasp Type: Folding Clasp With Safety



Dial Diameter: 43mm



Case Thickness: 12.3mm



Band Length: 245mm



Lug Width: 22mm



Strap Width at Buckle: 20mm



Product Weight: 134g



Feature: 30M Water Resistant, Day and Date Display, Luminous Hands',400,250,'product_images/81Owpu7ptWL._AC_UL480_FMwebp_QL65_.jpg','NF9204S',13,7);
INSERT INTO "products_product" VALUES (34,'Citizen Men''s Eco-Drive Sport Luxury World Chronograph Atomic Time Keeping Watch in Stainless Steel, Blue Dial (Model: AT8020-54L) watches','Eco-drive is fueled by light so it never needs a battery^Atomic timekeeping, the most accurate watch in the world^Automatic time in 26 world cities and radio-controlled in North America, United Kingdom, Europe, Japan and China^Sapphire crystal^Water-resistant to 200 M (660 feet)

Country of OriginJapan',700,600,'product_images/81JUiLK13cL._AC_SR3003750C_BR3_.jpg','AT8020-54L',13,9);
INSERT INTO "products_product" VALUES (35,'HAGGAR Mens Stretch Classic Fit Cargo Jeans Pant (Regular and Big and Tall Sizes)','FEATURES: This durable comfort stretch cotton cargo pant features a flat front, hidden expandable waistband, off-seam front pocket, single welt back pocket, in a classic fit silhouette.

MATERIAL: A comfortable minimal stretch cargo consisting of 99% Cotton, 1% Elastane for stretch and recovery.

COMFORT: There is no shortage of comfort here! The hidden expandable waistband stretches up to 3" for all day comfort.

STYLE: Our cargo pant is designed for utility without the extra bagginess. From the subtle stretch in our signature waistband to built-in spandex fibers. It''s no wonder we put "comfort" in the name.

EASY CARE: This cargo is light but provides the pocket utility to keep your essentials protected. Not to mention, this pant is machine washable!',200,100,'product_images/71eldQKTnYL._AC_SX679_.jpg','S04694',8,9);
INSERT INTO "products_product" VALUES (36,'Insulated Water Bottle w/Handle, Half Gallon, Fence Hook','MAXIMUM HYDRATION: Under Armour''s Playmaker Jug is perfect for tournaments or game days! It holds 64 ounces of liquid and its foam-insulation will keep your beverages cold for 10 hours

SUPER SIZE - No need to refill your flask between sessions or during tournaments, this super-sized water bottles got you covered

PRACTICAL - Built-in fence hooks holder for easy hang-up, marked with ounces & milliliters for easy measuring. The lid is dishwasher safe with self-draining cap helps prevent dishwasher puddle

GRIP - Non-slip side grip for a comfortable & secure hold, ergonomic side handle provides more support when drinking & carrying

TOP QUALITY – Made for kids and adults, BPA and Lead Free, perfect for all sports, at the gym, around',300,200,'product_images/61PQRMZMhWL._AC_SX679_.jpg','JHHDGH6785',9,9);
INSERT INTO "products_product" VALUES (37,'AND1 Over the Door Mini Basketball Hoop: 18x12 Shatterproof Backboard, 2 Mini Basketballs','EXPERIENCE INSTANT BASKETBALL FUN: Dive into the world of sports with the AND1 Over the Door Basketball Hoop, a perfect indoor basketball accessory. Unbox the excitement with a pre-assembled, no-tools-required design, making it an ideal mini basketball hoop for both kids and adults.

ELEVATE YOUR GAME WITH PROFESSIONAL FEATURES: Take your indoor basketball experience to new heights with the AND1 Over Door Basketball Hoop. Enjoy a 9” spring-loaded steel rim and a heavy-duty 3-ply net, making it a standout among mini hoops and indoor basketball accessories.

MAXIMUM DURABILITY AND DOOR PROTECTION: Safeguard your door while indulging in mini basketball games with the AND1 Mini Hoop. The professional-grade shatterproof backboard ensures durability, and the foam-padded backing protects your door, making it a top choice for an indoor basketball hoop.

UNLEASH YOUR INNER BALLER ANYWHERE: The AND1 Over the Door Mini Basketball Hoop caters to all ages, from toddlers to adults. It transforms any space into an indoor basketball arena, making it the go-to choice for mini basketball and indoor basketball enthusiasts.

BE DIFFERENT, CHOOSE AND1: Stand out in the world of basketball accessories with AND1. Embrace the AND1 difference with our innovative indoor basketball hoop, suitable for all ages. Whether you''re looking for a toddler basketball hoop or an over-the-door basketball hoop, choose AND1 for quality and excitement.',100,78,'product_images/81op3y4JMML.__AC_SX300_SY300_QL70_FMwebp_.jpg','ASS04694',9,7);
INSERT INTO "products_product" VALUES (38,'WLIVE Wood Lift Top Coffee Table with Hidden Compartment and Adjustable Storage Shelf, Lift Tabletop Dining Table for Home Living Room, Office, Rustic Oak','【Lift Top Design】When sitting on your sofa, the height of other center table may not be enough. This lift top coffee table has an extending top that lifts up to provide a floating raised work. surface,So you can working,dining and storage living room items here.

【Stable Lift Workbench】High quality lift top mechanism enables the tabletop to be lifted up or lowered down effortlessly and noiselessly, Children don''t have to worry about hurting their fingers when using.

【Plenty of Storage Space】Large hidden compartment beneath the tabletop is enough to store your often-used items like laptop, chess, and remote controllers, keeping them away from dirt.

【Removable Shelf】 The side drawer equipped with the removable shelf offers extra space for magazines, CDs, and game controllers.

【Modern Design】The wood grain table top creates the natural beauty of a rustic coffee table，Mid-century design makes the coffee table more modern,perfectly matches your room style and décor.',300,250,'product_images/81aa5NsLu1L.__AC_SX300_SY300_QL70_FMwebp_.jpg','ASP04694',12,7);
INSERT INTO "products_product" VALUES (39,'Yoobure Tree Bookshelf - 6 Shelf Retro Floor Standing Bookcase, Tall Wood Book Storage Rack for CDs/Movies/Books, Utility Book Organizer Shelves for Bedroom, Living Room, Home Office','【Modern Bookshelf Design】The book shelf combines modern design with vintage colors, and it presents a unique personality along with a warm atmosphere that can blend in with most home decor styles. The multifunctional partition design of the book case is perfect for displaying your books, CDs, magazines, video games, manga, decorations, novels, speakers and more.

【Save Space & Decor Room】Yoobure bookshelves dimensions: 44.48"H*15"L*"7.87"W. The corner bookcase has 6 storage areas, each storage area can hold 5–10 books. With its open design and small footprint, this narrow bookshelf is easy to move and organize, making it ideal for corners and small spaces and perfect for use in living rooms, offices and bedrooms. While saving space, this small bookshelf is also a work of art, suitable as a gift for family or friends.

【Sturdy & Durable】The skinny bookshelf is made of high-quality board material, which is not easy to break and has a tough and durable texture. And the tree geometric bookcase is designed with backboard reinforcement, which has strong load-bearing capacity. For added safety and stability, we offer anti tip furniture straps that allow you to secure corner bookshelf to the wall, especially for families with children and pets.',700,600,'product_images/61pfi70XekL.__AC_SX300_SY300_QL70_FMwebp_.jpg','CGT55WAD',12,9);
INSERT INTO "products_product" VALUES (40,'OXO Good Grips Sweep & Swipe Laptop Cleaner, White, One Size','Double-sided tool deep cleans laptops, tablets and smartphones

Microfiber pad removes fingerprints and smudges from screens and surfaces

Soft brush sweeps away dust and dirt

Retractable brush and storage cover keep both ends protected when not in use',25,20,'product_images/716VfcW-lL._AC_SY300_SX300_.jpg','DKS0469S',7,7);
INSERT INTO "products_product" VALUES (41,'Mademark x SpongeBob SquarePants clothes T-Shirts  - SpongeBob I am 6 Years Old Birthday Party T-Shirt','Official Licensed Products

Designed by Blink Imprints

Lightweight, Classic fit, Double-needle sleeve and bottom hem',25,20,'product_images/B1HVVUyLAhL._CLa_21402000_91BWZzLuPUL.png_00214020000.00.02140.02000.0_AC_SX466_.jpg','DK04694',1,10);
INSERT INTO "products_product" VALUES (42,'WMP Eyewear Round Sunglasses  fashion | Polarized UV Protection | Trendy Sunglasses for Women | Retro Designer Style','PREMIUM QUALITY: Crafted with durable five barrel stainless steel hinges and optical-grade materials like Acetate and TR90, our stylish sunglasses are stronger and more flexible than typical plastic frames. With exquisite temples and solid metal hinges, they''re both comfortable and long lasting.

AFFORDABLE LUXURY: Inspired by the latest trends, WMP sunglasses deliver the quality of designer shades without breaking the bank. From classic frames to modern styles, every single pair is (W)orn and (M)ade with (P)urpose.

TRUSTED PROTECTION: Whether you''re hiking, driving or just enjoying a day at the beach, our luxury sunglasses help shield your eyes from harmful rays. Featuring polarized lenses, they provide 99.99% UVA and UVB protection.',50,40,'product_images/61zzMDIq0IL._AC_SX569_.jpg','S0469ds4',10,9);
INSERT INTO "products_product" VALUES (43,'Disney Lion King Hakuna Matata T-Shirt for T-Shirts','Pull On Closure

Made in the USA or Imported

100% Cotton',45,20,'product_images/61p00diE9NL._AC_SX569_.jpg','KS0469P',1,9);
INSERT INTO "products_product" VALUES (44,'SAMSUNG Galaxy S22 Ultra smartphone','8K Video: Shoot videos with 8K resolution for epic quality

Adaptive Color: Auto adjusts color and brightness for outdoor and indoor viewing

Long Battery Life: 5000mAh battery provides all day power

S Pen Included: Use the S Pen for precise editing on the go

Premium Design: Glass and metal build with aluminum frame for durability

Water Resistant: Withstands splashes and accidental spills

USB Port: Quickly charge with included USB cable

Android 12: Upgrade to the latest Android OS',500,450,'product_images/7103aguWL5L.__AC_SY300_SX300_QL70_FMwebp_.jpg','SMS4512J',2,9);
INSERT INTO "products_product" VALUES (45,'SAMSUNG Galaxy Z Fold 6 AI smartphone','CIRCLE IT. FIND IT. SEE IT: Make huge discoveries when you use Circle to Search¹ with Google on the large screen of Galaxy Z Fold6; Circle those shoes on your feed and easily see where to buy them; Search is easier than ever on an expansive screen

TWO SCREENS. ZERO LANGUAGE BARRIER: Say bye to being lost in translation & hi to fluency in up to 16 languages with Interpreter with Galaxy AI; In FlexMode, phone displays translations on both sides of the screen for easy in-person conversation²

SMART AI EDITS. BRILLIANT PHOTOS: Editing photos is even easier on the large screen of Galaxy Z Fold6; See more detail as you instantly fix imperfections, move and remove objects and enhance colors using AI smart tools like Generative Edit and more³

IMMERSIVE SCREEN. IMPRESSIVE GRAPHICS: Level up your screen and level up your gaming experience; Totally immerse yourself with Galaxy Z Fold6 thanks to a huge screen, a lightning-fast processor and incredibly realistic graphics

MULTIPLE WINDOWS. MULTIPLE POSSIBILITIES: Edit, scroll and organize; Or chat, shop and stream — all at the same time on up to three windows; When it comes to viewing and doing more, Fold6 is built to handle more⁴

SUMMARIZE IN THE BLINK OF AI: Jot thoughts down and watch as Note Assist automatically creates shopping lists, organizes your notes and summarizes lengthy reads; Then view it all with ease on the large screen of Galaxy Z Fold6⁵

UNFOLD A GALAXY OF FITNESS: Track your health on the go with Galaxy X2 and get deeper insights on your Galaxy Z Fold6; By pairing the two, get personalized health tracking from your wrist and see results & actionable goals on the phone’s large screen⁶',1999.99,1598.99,'product_images/61896OtgvGL.__AC_SX300_SY300_QL70_FMwebp_.jpg','SUHGUIO7',2,7);
INSERT INTO "products_product" VALUES (46,'BOSTANTEN Quilted Crossbody bags Bags for Women Vegan Leather Purses Small Shoulder Handbags with Wide Strap','Fashion Designed: The crossbody bags with 1 main zipper pocket that contains 1 zip pocket + 1 slip pocket. External with 1 front zipper pocket. Top zipper closure ensures the safety of personal items

Premium Vegan Leather: Made of high-quality Vegan leather it is available in a variety of colors. Easy to clean & No any weird smell

Small & Lightweight: The small crossbody purse is 8.7"L*6.3"H*2.6"W. Small but also roomy space to hold daily essentials. Come with a detachable & adjustable long guitar strap (13.8" to 23.3" height)

Multi Wear Way: This crossbody bag is soft and lightweight. Our crossbody bag could be as a small crossbody purse, or as a shoulder bag for a daily time. Made of vegan leather and durable gold metal to make the crossbody bag more long-lasting',700,600,'product_images/image_2024-09-19_212723458.png','DKSSF4694',14,9);
INSERT INTO "products_product" VALUES (47,'FashionPuzzle Small Crescent bags Shoulder Bag Underarm Purse','9" (W) x 5" (H) x 2.5" (D)

Zipper closure

Adjustable shoulder strap with a minimum drop 9" to maximum drop 10"

Faux leather & gold tone hardware

1 slip pocket and 1 zipper pocket inside',866,563,'product_images/image_2024-09-19_212813021.png','SOJKD04694',14,7);
INSERT INTO "products_product" VALUES (48,'LOVEVOOK Laptop Backpack for bags Women, 15.6 Inch Work Business Backpacks Purse with USB Port, Large Capacity Nurse Bag College Bookbag for School, Waterproof Casual Daypack for Travel,Black-White-Brown','【Large Capacity Work Backpack】LOVEVOOK backpack purse for women uses a rectangular frame opening design to maintain large capacity and facilitate your quick access.

【Multi-Compartment Laptop backpack】Laptop backpack has a total of 5 compartments and 19 pockets, which are convenient for your organization and storage.

【Dimension】16.7*11.4*5.7 inch, Contains a separate computer compartment that can accommodate 15.6 inches and an iPad slot that can accommodate up to 11 inches.

【USB Port】The external USB interface of the Travel Backpack allows you to charge anytime and anywhere when you travel (excluding mobile power supply).

【Anti-Theft Pocket】Luggage strap allows you to easily fix your backpack on the trolley case. The anti-theft pocket on the back makes your valuables safer and your travel easier.

【Comfy & Sturdy】The shoulder belt and back are equipped with high-quality foam pads, which are breathable and pressure reducing. The large capacity and elastic side pockets can hold about 42oz water cups.

【Material】The Work Backpack is made of polyester and leather, exquisite and Sturdy, waterproof, light and soft, and easy to clean.

【Gift】Perfect gift for women, Whether young or adult women, nurses,Educators and other business people.',675,343,'product_images/71olG7l8KlL.__AC_SX300_SY300_QL70_FMwebp_.jpg','DFW45AS',14,10);
INSERT INTO "products_purchase" VALUES (1,1,'2024-09-17 12:51:25.052470',22,8);
INSERT INTO "products_purchase" VALUES (3,3,'2024-09-17 13:21:02.686163',19,8);
INSERT INTO "products_purchase" VALUES (4,1,'2024-09-17 13:21:02.797857',20,8);
INSERT INTO "products_purchase" VALUES (6,1,'2024-09-17 18:35:58.304998',9,8);
INSERT INTO "products_purchase" VALUES (7,1,'2024-09-17 18:35:58.379745',24,8);
INSERT INTO "products_purchase" VALUES (8,1,'2024-09-17 18:35:58.454273',23,8);
INSERT INTO "products_purchase" VALUES (9,1,'2024-09-17 18:41:02.778536',6,8);
INSERT INTO "products_purchase" VALUES (10,2,'2024-09-17 18:41:02.875377',7,8);
INSERT INTO "products_purchase" VALUES (13,1,'2024-09-17 18:46:53.882514',9,8);
INSERT INTO "products_purchase" VALUES (14,1,'2024-09-19 08:35:03.931766',6,8);
INSERT INTO "products_purchase" VALUES (15,1,'2024-09-19 14:49:27.083504',30,8);
INSERT INTO "products_purchase" VALUES (16,1,'2024-09-19 15:01:43.293180',32,8);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_group_permissions_group_id_permission_id_0cd325b0_uniq" ON "auth_group_permissions" (
	"group_id",
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "auth_group_permissions_group_id_b120cbf9" ON "auth_group_permissions" (
	"group_id"
);
CREATE INDEX IF NOT EXISTS "auth_group_permissions_permission_id_84c5c92e" ON "auth_group_permissions" (
	"permission_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_user_groups_user_id_group_id_94350c0c_uniq" ON "auth_user_groups" (
	"user_id",
	"group_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_groups_user_id_6a12ed8b" ON "auth_user_groups" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_groups_group_id_97559544" ON "auth_user_groups" (
	"group_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_user_user_permissions_user_id_permission_id_14a6b632_uniq" ON "auth_user_user_permissions" (
	"user_id",
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_user_permissions_user_id_a95ead1b" ON "auth_user_user_permissions" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_user_permissions_permission_id_1fbb5f2c" ON "auth_user_user_permissions" (
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "account_emailconfirmation_email_address_id_5b7f8c58" ON "account_emailconfirmation" (
	"email_address_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "account_emailaddress_user_id_email_987c8728_uniq" ON "account_emailaddress" (
	"user_id",
	"email"
);
CREATE UNIQUE INDEX IF NOT EXISTS "unique_verified_email" ON "account_emailaddress" (
	"email"
) WHERE "verified";
CREATE INDEX IF NOT EXISTS "account_emailaddress_user_id_2c513194" ON "account_emailaddress" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "account_emailaddress_email_03be32b2" ON "account_emailaddress" (
	"email"
);
CREATE UNIQUE INDEX IF NOT EXISTS "unique_primary_email" ON "account_emailaddress" (
	"user_id",
	"primary"
) WHERE "primary";
CREATE INDEX IF NOT EXISTS "django_admin_log_content_type_id_c4bce8eb" ON "django_admin_log" (
	"content_type_id"
);
CREATE INDEX IF NOT EXISTS "django_admin_log_user_id_c564eba6" ON "django_admin_log" (
	"user_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "django_content_type_app_label_model_76bd3d3b_uniq" ON "django_content_type" (
	"app_label",
	"model"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_permission_content_type_id_codename_01ab375a_uniq" ON "auth_permission" (
	"content_type_id",
	"codename"
);
CREATE INDEX IF NOT EXISTS "auth_permission_content_type_id_2f476e4b" ON "auth_permission" (
	"content_type_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "dashboard_customerdashboard_recent_purchases_customerdashboard_id_product_id_2d663857_uniq" ON "dashboard_customerdashboard_recent_purchases" (
	"customerdashboard_id",
	"product_id"
);
CREATE INDEX IF NOT EXISTS "dashboard_customerdashboard_recent_purchases_customerdashboard_id_a576bab9" ON "dashboard_customerdashboard_recent_purchases" (
	"customerdashboard_id"
);
CREATE INDEX IF NOT EXISTS "dashboard_customerdashboard_recent_purchases_product_id_5aa4ee1f" ON "dashboard_customerdashboard_recent_purchases" (
	"product_id"
);
CREATE INDEX IF NOT EXISTS "django_session_expire_date_a5c62663" ON "django_session" (
	"expire_date"
);
CREATE UNIQUE INDEX IF NOT EXISTS "socialaccount_socialtoken_app_id_account_id_fca4e0ac_uniq" ON "socialaccount_socialtoken" (
	"app_id",
	"account_id"
);
CREATE INDEX IF NOT EXISTS "socialaccount_socialtoken_account_id_951f210e" ON "socialaccount_socialtoken" (
	"account_id"
);
CREATE INDEX IF NOT EXISTS "socialaccount_socialtoken_app_id_636a42d7" ON "socialaccount_socialtoken" (
	"app_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "socialaccount_socialaccount_provider_uid_fc810c6e_uniq" ON "socialaccount_socialaccount" (
	"provider",
	"uid"
);
CREATE INDEX IF NOT EXISTS "socialaccount_socialaccount_user_id_8146e70c" ON "socialaccount_socialaccount" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "products_cart_product_id_52080291" ON "products_cart" (
	"product_id"
);
CREATE INDEX IF NOT EXISTS "products_cart_user_id_d53bf7cf" ON "products_cart" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "products_product_category_id_9b594869" ON "products_product" (
	"category_id"
);
CREATE INDEX IF NOT EXISTS "products_product_seller_id_07afb1e3" ON "products_product" (
	"seller_id"
);
CREATE INDEX IF NOT EXISTS "products_purchase_product_id_e69ea49c" ON "products_purchase" (
	"product_id"
);
CREATE INDEX IF NOT EXISTS "products_purchase_customer_id_9cba3e1a" ON "products_purchase" (
	"customer_id"
);
CREATE INDEX IF NOT EXISTS "products_purchaseitem_product_id_f27d85c1" ON "products_purchaseitem" (
	"product_id"
);
CREATE INDEX IF NOT EXISTS "products_purchaseitem_purchase_id_2e6c6d1c" ON "products_purchaseitem" (
	"purchase_id"
);
COMMIT;

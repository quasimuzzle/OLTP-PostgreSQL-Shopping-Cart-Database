CREATE TABLE IF NOT EXISTS "User" (
	"UserID" serial NOT NULL UNIQUE,
	"FullName" varchar(255) NOT NULL,
	"PhoneNumber" bigint NOT NULL,
	"Email" varchar(255) NOT NULL,
	"CardID" numeric(10,0) NOT NULL,
	PRIMARY KEY ("UserID")
);

CREATE TABLE IF NOT EXISTS "Order" (
	"OrderID" serial NOT NULL UNIQUE,
	"UserID" bigint NOT NULL,
	"OrderDate" timestamp with time zone NOT NULL,
	"OrderStatus" varchar(255) NOT NULL,
	"PaymentStatus" varchar(255) NOT NULL,
	"ExpectedDeliveryDate" timestamp with time zone NOT NULL,
	"DeliveryAddress" varchar(255) NOT NULL,
	"PickupPointID" bigint NOT NULL,
	"CourierServiceID" bigint NOT NULL,
	PRIMARY KEY ("OrderID")
);

CREATE TABLE IF NOT EXISTS "Product" (
	"ProductID" serial NOT NULL UNIQUE,
	"ProductName" varchar(255) NOT NULL,
	"Price" numeric(10,0) NOT NULL,
	"StockQuantity" bigint NOT NULL,
	"Description" varchar(255) NOT NULL,
	PRIMARY KEY ("ProductID")
);

CREATE TABLE IF NOT EXISTS "OrderItem" (
	"OrderItemID" serial NOT NULL UNIQUE,
	"OrderID" bigint NOT NULL,
	"ProductID" bigint NOT NULL,
	"Quantity" bigint NOT NULL,
	PRIMARY KEY ("OrderItemID")
);

CREATE TABLE IF NOT EXISTS "PickupPoint" (
	"PickupPointID" serial NOT NULL UNIQUE,
	"Address" varchar(255) NOT NULL,
	PRIMARY KEY ("PickupPointID")
);

CREATE TABLE IF NOT EXISTS "CourierService" (
	"CourierServiceID" serial NOT NULL UNIQUE,
	"ServiceName" varchar(255) NOT NULL,
	"DeliveryTimeEstimate" varchar(255) NOT NULL,
	PRIMARY KEY ("CourierServiceID")
);

CREATE TABLE IF NOT EXISTS "TransactionLog" (
	"LogID_" serial NOT NULL UNIQUE,
	"UserID" bigint NOT NULL,
	"OrderID" bigint NOT NULL,
	"Action" varchar(255) NOT NULL,
	"Timestamp" timestamp with time zone NOT NULL,
	PRIMARY KEY ("LogID_")
);

ALTER TABLE "User" ADD CONSTRAINT "User_fk0" FOREIGN KEY ("UserID") REFERENCES "Order"("UserID");
ALTER TABLE "Order" ADD CONSTRAINT "Order_fk0" FOREIGN KEY ("OrderID") REFERENCES "OrderItem"("OrderID");

ALTER TABLE "Order" ADD CONSTRAINT "Order_fk7" FOREIGN KEY ("PickupPointID") REFERENCES "PickupPoint"("PickupPointID");

ALTER TABLE "Order" ADD CONSTRAINT "Order_fk8" FOREIGN KEY ("CourierServiceID") REFERENCES "CourierService"("CourierServiceID");
ALTER TABLE "Product" ADD CONSTRAINT "Product_fk0" FOREIGN KEY ("ProductID") REFERENCES "OrderItem"("ProductID");



ALTER TABLE "TransactionLog" ADD CONSTRAINT "TransactionLog_fk1" FOREIGN KEY ("UserID") REFERENCES "User"("UserID");

ALTER TABLE "TransactionLog" ADD CONSTRAINT "TransactionLog_fk2" FOREIGN KEY ("OrderID") REFERENCES "Order"("OrderID");
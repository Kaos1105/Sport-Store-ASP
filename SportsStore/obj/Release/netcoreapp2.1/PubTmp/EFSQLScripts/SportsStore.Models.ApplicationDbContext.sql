﻿IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20191016201100_Initial')
BEGIN
    CREATE TABLE [Orders] (
        [OrderID] int NOT NULL IDENTITY,
        [Shipped] bit NOT NULL,
        [Name] nvarchar(max) NOT NULL,
        [Line1] nvarchar(max) NOT NULL,
        [Line2] nvarchar(max) NULL,
        [Line3] nvarchar(max) NULL,
        [City] nvarchar(max) NOT NULL,
        [State] nvarchar(max) NOT NULL,
        [Zip] nvarchar(max) NULL,
        [Country] nvarchar(max) NOT NULL,
        [GiftWrap] bit NOT NULL,
        CONSTRAINT [PK_Orders] PRIMARY KEY ([OrderID])
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20191016201100_Initial')
BEGIN
    CREATE TABLE [Products] (
        [ProductID] int NOT NULL IDENTITY,
        [Name] nvarchar(max) NOT NULL,
        [Description] nvarchar(max) NOT NULL,
        [Price] decimal(18, 2) NOT NULL,
        [Category] nvarchar(max) NOT NULL,
        CONSTRAINT [PK_Products] PRIMARY KEY ([ProductID])
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20191016201100_Initial')
BEGIN
    CREATE TABLE [CartLine] (
        [CartLineID] int NOT NULL IDENTITY,
        [ProductID] int NULL,
        [Quantity] int NOT NULL,
        [OrderID] int NULL,
        CONSTRAINT [PK_CartLine] PRIMARY KEY ([CartLineID]),
        CONSTRAINT [FK_CartLine_Orders_OrderID] FOREIGN KEY ([OrderID]) REFERENCES [Orders] ([OrderID]) ON DELETE NO ACTION,
        CONSTRAINT [FK_CartLine_Products_ProductID] FOREIGN KEY ([ProductID]) REFERENCES [Products] ([ProductID]) ON DELETE NO ACTION
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20191016201100_Initial')
BEGIN
    CREATE INDEX [IX_CartLine_OrderID] ON [CartLine] ([OrderID]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20191016201100_Initial')
BEGIN
    CREATE INDEX [IX_CartLine_ProductID] ON [CartLine] ([ProductID]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20191016201100_Initial')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20191016201100_Initial', N'2.1.11-servicing-32099');
END;

GO


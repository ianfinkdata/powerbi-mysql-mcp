-- =====================================================================
-- 01_create_database.sql
-- Creates the sales_pipeline database used by the Power BI MCP demo.
-- Run this first, then run 02_create_tables.sql.
-- =====================================================================

DROP DATABASE IF EXISTS sales_pipeline;

CREATE DATABASE sales_pipeline
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE sales_pipeline;

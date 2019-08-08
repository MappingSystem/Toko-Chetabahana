# -*- coding: utf-8 -*-
# Generated by Django 1.10.1 on 2016-09-06 12:41
from __future__ import unicode_literals

import django_prices.models
from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [("order", "0012_auto_20160216_1032")]

    operations = [
        migrations.AlterField(
            model_name="deliverygroup",
            name="status",
            field=models.CharField(
                choices=[
                    ("new", "Processing"),
                    ("cancelled", "Cancelled"),
                    ("shipped", "Shipped"),
                    ("payment-pending", "Payment pending"),
                    ("fully-paid", "Fully paid"),
                ],
                default="new",
                max_length=32,
                verbose_name="delivery status",
            ),
        ),
        migrations.AlterField(
            model_name="order",
            name="status",
            field=models.CharField(
                choices=[
                    ("new", "Processing"),
                    ("cancelled", "Cancelled"),
                    ("shipped", "Shipped"),
                    ("payment-pending", "Payment pending"),
                    ("fully-paid", "Fully paid"),
                ],
                default="new",
                max_length=32,
                verbose_name="order status",
            ),
        ),
        migrations.AlterField(
            model_name="order",
            name="total_net",
            field=django_prices.models.MoneyField(
                blank=True,
                currency=settings.DEFAULT_CURRENCY,
                decimal_places=2,
                max_digits=12,
                null=True,
                verbose_name="total",
            ),
        ),
        migrations.AlterField(
            model_name="order",
            name="total_tax",
            field=django_prices.models.MoneyField(
                blank=True,
                currency=settings.DEFAULT_CURRENCY,
                decimal_places=2,
                max_digits=12,
                null=True,
                verbose_name="total",
            ),
        ),
        migrations.AlterField(
            model_name="orderhistoryentry",
            name="status",
            field=models.CharField(
                choices=[
                    ("new", "Processing"),
                    ("cancelled", "Cancelled"),
                    ("shipped", "Shipped"),
                    ("payment-pending", "Payment pending"),
                    ("fully-paid", "Fully paid"),
                ],
                max_length=32,
                verbose_name="order status",
            ),
        ),
    ]
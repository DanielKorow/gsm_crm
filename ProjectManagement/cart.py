import datetime
from .models import Cart, TemporaryOrder
from django.utils import timezone
import pytz

CART_ID = 'CART-ID'


class ItemDoesNotExist(Exception):
    pass


class Cart_(object):
    def __init__(self, request):
        cart_id = request.session.get(CART_ID)
        if cart_id:
            try:
                cart = Cart.objects.get(id=cart_id, checked_out=False)
            except Cart.DoesNotExist:
                cart = self.new(request)
        else:
            cart = self.new(request)
        self.cart = cart

        
    def new(self, request):
        cart = Cart(creation_date=datetime.datetime.now())
        cart.save()
        request.session[CART_ID] = cart.id
        return cart


    def add(self, product, app_method, client, material, price, prepayment, info, quantity=1):
        # try:
        #     temp_order = TemporaryOrder.objects.get(cart=self.cart, item=product, app_method=app_method, client=client, material=material, price=price) 
        # except TemporaryOrder.DoesNotExist:
        if int(quantity) == 0:
            quantity = 1
        temp_order = TemporaryOrder(cart=self.cart, item=product, app_method=app_method, 
            quantity=quantity, client=client, material=material, price=price, pre_payment=prepayment, info=info)
        temp_order.save()
        # else:
        #     temp_order.quantity = temp_order.quantity + int(quantity)
        #     temp_order.save()


    def get_cart(self, client):
        cart = TemporaryOrder.objects.filter(cart=self.cart, client=client)
        return cart


    def remove_position(self, position):
        try:
            item = TemporaryOrder.objects.get(id=position, cart=self.cart)
        except models.Item.DoesNotExist:
            raise ItemDoesNotExist    
        else:
            item.delete()


    def summary(self, client):
        result = 0
        for item in TemporaryOrder.objects.filter(cart=self.cart, client=client):
            result += item.total_price
        return result


    def clear(self):
        self.cart.delete()
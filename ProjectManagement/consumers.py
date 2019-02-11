from channels.generic.websocket import AsyncWebsocketConsumer
import json
from . models import *
from django.contrib.auth.models import User
from django.core import serializers
from channels.db import database_sync_to_async


class OrderNumberConsumer(AsyncWebsocketConsumer):
    async def connect(self):
        self.order_number = self.scope['url_route']['kwargs']['order_number']
        self.order_group_name = 'chat_%s' % self.order_number

        # Join room group
        await self.channel_layer.group_add(
            self.order_group_name,
            self.channel_name
        )

        await self.accept()

    async def disconnect(self, close_code):
        # Leave room group
        await self.channel_layer.group_discard(
            self.order_group_name,
            self.channel_name
        )

    # Receive message from WebSocket
    async def receive(self, text_data):
        text_data_json = json.loads(text_data)
        message = text_data_json['message']
        id_user = text_data_json['id_user']
        order_id = text_data_json['id'] 
        await self.save_msg(order_id, id_user, message)
        await self.channel_layer.group_send(
            self.order_group_name,
            {
                'type': 'chat_message',
                'message': message,
                'obj_user': await self.get_user(id_user)
            }
        )

    @database_sync_to_async
    def save_msg(self, order_id, id_user, message):
        chat_save = NewChatOrder(order=OrderNumber.objects.get(id=order_id), message=message, user=User.objects.get(id=id_user))
        chat_save.save()

    @database_sync_to_async
    def get_user(self, id_user):
        return User.objects.get(id=id_user).first_name + " " + User.objects.get(id=id_user).last_name


    # Receive message from room group
    async def chat_message(self, event):
        message = event['message']
        obj_user = event['obj_user']

        # Send message to WebSocket
        await self.send(text_data=json.dumps({
            'message': message,
            'obj_user': obj_user,
        }))


class PositionNumberConsumer(AsyncWebsocketConsumer):
    async def connect(self):
        self.position_number = self.scope['url_route']['kwargs']['position_number']
        self.position_group_name = 'chat_%s' % self.position_number

        # Join room group
        await self.channel_layer.group_add(
            self.position_group_name,
            self.channel_name
        )

        await self.accept()

    async def disconnect(self, close_code):
        # Leave room group
        await self.channel_layer.group_discard(
            self.position_group_name,
            self.channel_name
        )

    # Receive message from WebSocket
    async def receive(self, text_data):
        text_data_json = json.loads(text_data)
        image = text_data_json['image']
        message = text_data_json['message']
        id_user = text_data_json['id_user']
        order_id = text_data_json['id'] 
        await self.save_msg(order_id, id_user, message, image)
        await self.channel_layer.group_send(
            self.position_group_name,
            {
                'type': 'chat_message',
                'image': image,
                'message': message,
                'obj_user': await self.get_user(id_user),
            }
        )


    @database_sync_to_async
    def save_msg(self, order_id, id_user, message, image):
        chat_save = NewChatPosition(position=Order.objects.get(id=order_id), message=message, user=User.objects.get(id=id_user), image=image)
        chat_save.save()

    @database_sync_to_async
    def get_user(self, id_user):
        return User.objects.get(id=id_user).first_name + " " + User.objects.get(id=id_user).last_name

    # Receive message from room group
    async def chat_message(self, event):
        message = event['message']
        obj_user = event['obj_user']
        image = event['image']

        # Send message to WebSocket
        await self.send(text_data=json.dumps({
            'image': image,
            'message': message,
            'obj_user': obj_user,
        }))

from django.conf.urls import url

from . import consumers

websocket_urlpatterns = [
    url(r'^ws/order/(?P<order_number>[^/]+)/$', consumers.OrderNumberConsumer),
    url(r'^ws/position/(?P<position_number>[^/]+)/$', consumers.PositionNumberConsumer),
]
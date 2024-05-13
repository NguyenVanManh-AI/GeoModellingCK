# urls.py

from django.urls import path
from .views import LocationList, LocationCreate

urlpatterns = [
    path('', LocationList.as_view(), name='location-list'),
    path('create/', LocationCreate.as_view(), name='location-create'),
]

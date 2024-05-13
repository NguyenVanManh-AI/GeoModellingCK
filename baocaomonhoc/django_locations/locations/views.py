from rest_framework import generics
from .models import Location
from .serializers import LocationSerializer
from rest_framework.exceptions import ValidationError
from rest_framework.response import Response
from rest_framework import status

class LocationList(generics.ListAPIView):
    print("LocationList")
    queryset = Location.objects.all()
    serializer_class = LocationSerializer

class LocationCreate(generics.CreateAPIView):
    print("LocationCreate")
    queryset = Location.objects.all()
    serializer_class = LocationSerializer

    # def perform_create(self, serializer):
    #     queryset = Location.objects.filter(name=serializer.validated_data['name'])
    #     if queryset.exists():
    #         raise ValidationError('Location already exists')
    #     serializer.save()
    
    def create(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        if serializer.is_valid():
            queryset = Location.objects.filter(name=serializer.validated_data['name'])
            if queryset.exists():
                return Response({'error': 'Location already exists'}, status=status.HTTP_400_BAD_REQUEST)
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        else:
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
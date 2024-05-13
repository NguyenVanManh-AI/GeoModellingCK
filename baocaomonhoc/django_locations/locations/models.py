from django.db import models

# Create your models here.
class Location(models.Model):
    name = models.CharField(max_length=100)
    latitude = models.FloatField()
    longitude = models.FloatField()
    # ảnh gồm có 6 ảnh px, nx, py, ny, pz, nz
    path360 = models.CharField(max_length=100)

    def __str__(self):
        return self.name

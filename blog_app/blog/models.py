from django.db import models

# Create your models here.
# myapp/models.py
from django.db import models
from django.contrib.auth.models import User

class Post(models.Model):
    title = models.CharField(max_length=255)
    summary = models.TextField(blank=True)
    content = models.TextField()
    author = models.ForeignKey(User, on_delete=models.CASCADE)
    created_at = models.DateTimeField(auto_now_add=True)
    
    def save(self, *args, **kwargs):
        if not self.summary:
            self.summary = self.content[:100] + "..."  # simple summary logic
        super().save(*args, **kwargs)

    def __str__(self):
        return self.title

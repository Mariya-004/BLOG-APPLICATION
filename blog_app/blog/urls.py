# myapp/urls.py
from django.urls import path
from .views import (
    LoginAPIView,
    PostListAPIView,
    PostDetailAPIView,
    PostCreateAPIView,
)

urlpatterns = [
    path('login/', LoginAPIView.as_view(), name='api-login'),
    path('posts/', PostListAPIView.as_view(), name='post-list'),
    path('posts/<int:id>/', PostDetailAPIView.as_view(), name='post-detail'),
    path('posts/create/', PostCreateAPIView.as_view(), name='post-create'),
]

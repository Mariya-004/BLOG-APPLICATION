from django.shortcuts import render

# Create your views here.
# myapp/views.py
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import generics, status, permissions
from django.contrib.auth import authenticate
from rest_framework.authtoken.models import Token

from .models import Post
from .serializers import (
    LoginSerializer,
    PostListSerializer,
    PostDetailSerializer,
    PostCreateSerializer
)

# 1. Login API
class LoginAPIView(APIView):
    def post(self, request):
        serializer = LoginSerializer(data=request.data)
        if serializer.is_valid():
            user = authenticate(
                username=serializer.validated_data['username'],
                password=serializer.validated_data['password']
            )
            if user:
                token, _ = Token.objects.get_or_create(user=user)
                return Response({'token': token.key, 'user_id': user.id})
            return Response({'error': 'Invalid credentials'}, status=400)
        return Response(serializer.errors, status=400)

# 2. Post List (Public)
class PostListAPIView(generics.ListAPIView):
    queryset = Post.objects.all().order_by('-created_at')
    serializer_class = PostListSerializer

# 3. Post Detail (Public)
class PostDetailAPIView(generics.RetrieveAPIView):
    queryset = Post.objects.all()
    serializer_class = PostDetailSerializer
    lookup_field = 'id'

# 4. Create Post (Authenticated)
class PostCreateAPIView(generics.CreateAPIView):
    serializer_class = PostCreateSerializer
    permission_classes = [permissions.IsAuthenticated]

    def perform_create(self, serializer):
        serializer.save(author=self.request.user)

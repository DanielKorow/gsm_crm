from django.shortcuts import render
from django.http import HttpResponseRedirect, HttpResponse
from django.shortcuts import redirect
from django.conf import settings
from django.views.generic import View
from .models import *
from .forms import *
from django.contrib.auth.models import User
from django.contrib.auth import authenticate
from django.contrib.auth import login as user_login
from django.contrib.auth import logout as user_logout
from django.contrib import auth
from django.contrib.auth.models import Group, Permission
from django.contrib.contenttypes.models import ContentType
from .models import *
from django.contrib.auth.decorators import login_required, permission_required
from django import forms
from django.core.mail import send_mail, EmailMessage
from django.utils.decorators import method_decorator
from .cart import Cart_
from django.forms.formsets import formset_factory
from django.forms import modelformset_factory
from django.http import JsonResponse


class Installation(View):

    template = 'installation/install.html'

    # Статусы позиции должны быть строго такими: 'На просчёте', 'Просчитан', 'Дизайн', 'В производстве', 'Сдан'

    def get(self, request):
        return render(request, self.template)


    def post(self, request):
        User.objects.create_user(username=request.POST['login'], password=request.POST['password'], is_superuser=True, is_staff=True, is_active=True)
        content_type = ContentType.objects.get_for_model(User)
        managers, created = Group.objects.get_or_create(name='Managers')
        designers, created = Group.objects.get_or_create(name='Designers')
        productions, created = Group.objects.get_or_create(name='Productions')
        logists, created = Group.objects.get_or_create(name='Logists')
        clients, created = Group.objects.get_or_create(name='Clients')
        manager_rw, created = Permission.objects.get_or_create(codename='manager_rw', name='Manager Read and Write', content_type=content_type)
        manage_clients, created = Permission.objects.get_or_create(codename='manage_clients', name='Can create and change clients', content_type=content_type)
        designer_rw, created = Permission.objects.get_or_create(codename='designer_rw', name='Designer Read and Write', content_type=content_type)     
        production_rw, created = Permission.objects.get_or_create(codename='production_rw', name='Production Read and Write', content_type=content_type)     
        logist_rw, created = Permission.objects.get_or_create(codename='logist_rw', name='Logist Read and Write', content_type=content_type)
        client_rw, created = Permission.objects.get_or_create(codename='client_rw', name='Client Read and Write', content_type=content_type)
        managers.permissions.add(manager_rw)
        managers.permissions.add(manage_clients)
        designers.permissions.add(designer_rw)
        productions.permissions.add(production_rw)
        logists.permissions.add(logist_rw)
        clients.permissions.add(client_rw)
        return HttpResponseRedirect('/admin')
        

def logout(request):
    user_logout(request)
    return HttpResponseRedirect('/')


class Login(View):

    template = 'login/login.html'

    def get(self, request):
        user = auth.get_user(request)
        if user.is_superuser:
            return HttpResponseRedirect('/admin')
        if user.has_perm('auth.manager_rw'):
            return HttpResponseRedirect('/manager/orders/recently')
        if user.has_perm('auth.client_rw'):
            return HttpResponseRedirect('/client/orders/recently')
        if user.has_perm('auth.designer_rw'):
            return HttpResponseRedirect('/designer/orders/recently')
        if user.has_perm('auth.production_rw'):
            return HttpResponseRedirect('/production/orders/recently')
        if user.has_perm('auth.logist_rw'):
            return HttpResponseRedirect('/logist/orders/recently')    
        login_form = LoginForm()
        context = {
            'login_form': login_form,
        }
        return render(request, self.template, context)


    def post(self, request):
        login_form = LoginForm(request.POST)
        if login_form.is_valid():
            email = login_form.cleaned_data['email']
            password = login_form.cleaned_data['password']
            try:
                user = authenticate(username=email, password=password)
            except:
                error_message = "Неверный email или пароль"
                login_form = LoginForm()
                context = {
                    'login_form': login_form,
                    'error': error_message
                }
                return render(request, 'login/login.html', context)
            if user is not None:
                if user.is_active:
                    user_login(request, user)
                    if user.is_superuser:
                        return HttpResponseRedirect('/admin')
                    if user.has_perm('auth.manager_rw'):
                        return HttpResponseRedirect('/manager/orders/recently')
                    if user.has_perm('auth.clients_rw'):
                        return HttpResponseRedirect('/client/orders/recently')
                    if user.has_perm('auth.designer_rw'):
                        return HttpResponseRedirect('/designer/orders/recently')
                    if user.has_perm('auth.production_rw'):
                        return HttpResponseRedirect('/production/orders/recently')
                    if user.has_perm('auth.logist_rw'):
                        return HttpResponseRedirect('/logist/orders/recently')  
            return HttpResponseRedirect('/')
        return HttpResponseRedirect('/')


class DocDelete(View):
    def get(self, request, pk):
        OrderDocuments.objects.get(id=pk).delete()
        return HttpResponseRedirect('/')


class DeleteClientFile(View):
    def get(self, request, pk):
        ClientDocuments.objects.get(id=pk).delete()
        return HttpResponseRedirect(request.GET.get('next'))


class RemoveBrandbook(View):
    def get(self, request, pk):
        ClientBrandbook.objects.get(id=pk).delete()
        return HttpResponseRedirect(request.GET.get('next'))


class DeleteTReq(View):
    def get(self, request, pk):
        DesignerTReq.objects.get(id=pk).delete()
        return HttpResponseRedirect(request.GET.get('next'))


class ChatFileDelete(View):
    def get(self, request, pk):
        FilesForChat.objects.get(id=pk).delete()
        return HttpResponseRedirect(request.GET.get('next'))
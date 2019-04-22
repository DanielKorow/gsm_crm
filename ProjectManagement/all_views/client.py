from django.shortcuts import render
from django.http import HttpResponseRedirect, HttpResponse
from django.shortcuts import redirect
from django.conf import settings
from django.views.generic import View
from ..models import *
from ..forms import *
from django.contrib.auth.models import User
from django.contrib.auth import authenticate
from django.contrib.auth import login as user_login
from django.contrib.auth import logout as user_logout
from django.contrib import auth
from django.contrib.auth.models import Group, Permission
from django.contrib.contenttypes.models import ContentType
from ..models import *
from django.contrib.auth.decorators import login_required, permission_required
from django import forms
from django.core.mail import send_mail, EmailMessage
from django.utils.decorators import method_decorator
from ..cart import Cart_
from django.forms.formsets import formset_factory
from django.forms import modelformset_factory
from django.http import JsonResponse

class Client(View):

    @method_decorator(permission_required('auth.client_rw'))
    def get(self, request):
        pass

    @method_decorator(permission_required('auth.client_rw'))
    def post(self, request):
        pass


class ClientOrders(View):
    template = "client/orders.html"

    @method_decorator(permission_required('auth.client_rw'))
    def get(self, request, status):
        user = auth.get_user(request)
        client = ClientProfile.objects.get(user=user)
        try:
            if status == "done":
                orders = OrderNumber.objects.filter(status_done=True, client=client)
            else:
                orders = OrderNumber.objects.filter(status_done=False, client=client)
        except:
            orders = ""
        context = {
            'active_home': 'active',
            'orders': orders,
        }
        return render(request, self.template, context)


class ClientOrders_edit(View):
    template = "client/order.html"

    @method_decorator(permission_required('auth.client_rw'))
    def get(self, request, pk):
        order_id = OrderNumber.objects.get(id=pk)
        order_id.mark_designer = False
        order_id.save()
        order = Order.objects.filter(order=order_id)
        docs = OrderDocuments.objects.filter(order=order_id)
        order_edit = AddDocForm()
        context = {
            'file_upload_form': FilesForChatForm(),               # Файлы для чата
            'files': FilesForChat.objects.filter(order=order_id), # Файлы для чата
            'active_home': 'active',
            'order': order,
            'docs': docs,
            'order_edit': order_edit,
            'order_id': order_id,
            'summary': OrderNumber.objects.summary(pk),
            'pre_payment': OrderNumber.objects.pre_payment(pk),
            'post_payment': OrderNumber.objects.post_payment(pk),
            'order_chat': NewChatOrder.objects.filter(order=order_id),
        }
        return render(request, self.template, context)

    @method_decorator(permission_required('auth.client_rw'))
    def post(self, request, pk):
        if 'file_for_chat' in request.POST:
            files_for_chat = FilesForChatForm(request.POST, request.FILES) # Файлы для чата
            if files_for_chat.is_valid():                                  # Файлы для чата
                s = files_for_chat.save(commit=False)                      # Файлы для чата
                s.order = OrderNumber.objects.get(id=pk)                   # Файлы для чата
                s.user = request.user                                      # Файлы для чата
                s.save()                                                   # Файлы для чата
        # files_for_chat = FilesForChatForm(request.POST, request.FILES) # Файлы для чата
        # if files_for_chat.is_valid():                                  # Файлы для чата
        #     s = files_for_chat.save(commit=False)                      # Файлы для чата
        #     s.order = OrderNumber.objects.get(id=pk)                   # Файлы для чата
        #     s.user = request.user                                      # Файлы для чата
        #     s.save()                                                   # Файлы для чата
        if 'docs' in request.POST:
            docs = AddDocForm(request.POST, request.FILES)
            if docs.is_valid():
                doc = OrderDocuments()
                doc.title = docs.cleaned_data['title']
                doc.discription = docs.cleaned_data['discription']
                doc.file = docs.cleaned_data['file']
                doc.order = OrderNumber.objects.get(id=pk)
                doc.save()
        return HttpResponseRedirect(request.path)       


class ClientSelfProfile(View):
    template = "client/profile.html"

    @method_decorator(permission_required('auth.client_rw'))
    def get(self, request, pk):
        client_profile = ClientProfile.objects.get(user__id=pk)
        client_docs = ClientDocuments.objects.filter(client=client_profile)
        brandbook_docs = ClientBrandbook.objects.filter(client=client_profile)
        client_docs_form = ClientDocumentsForm()
        client_brand_form = ClientBrandbookForm()
        context = {
            'client_profile': client_profile,
            'client_docs': client_docs,
            'client_brandbook': brandbook_docs,
            'docs': client_docs_form,
            'brandbook': client_brand_form,
        }
        return render(request, self.template, context)

    @method_decorator(permission_required('auth.client_rw'))
    def post(self, request, pk):
        if request.POST.get('add_file', 'no') == 'yes':
            client_docs_form = ClientDocumentsForm(request.POST, request.FILES)
            if client_docs_form.is_valid():
                docs = client_docs_form.save(commit=False)
                docs.client = ClientProfile.objects.get(user__id=pk)
                docs.save()
                return HttpResponseRedirect('/client/profile/{0}'.format(pk))
        if request.POST.get('add_brand', 'no') == 'yes':
            client_brand_form = ClientBrandbookForm(request.POST, request.FILES)
            if client_brand_form.is_valid():
                docs = client_brand_form.save(commit=False)
                docs.client = ClientProfile.objects.get(user__id=pk)
                docs.save()
                return HttpResponseRedirect('/client/profile/{0}'.format(pk))
        return HttpResponseRedirect('/profile/{0}'.format(pk))


class ClientSelfProfileChange(View):
    template = 'client/change_profile.html'

    @method_decorator(permission_required('auth.client_rw'))
    def get(self, request, pk):
        client_profile = ClientProfile.objects.get(user__id=pk)
        client_profile_form = ClientProfileForm(instance=client_profile)
        context = {
            'active_clients': 'active',
            'client_profile': client_profile,
            'client_profile_form': client_profile_form,
        }
        return render(request, self.template, context)

    @method_decorator(permission_required('auth.client_rw'))
    def post(self, request, pk):
        client_profile = ClientProfile.objects.get(user__id=pk)
        client_profile_form = ClientProfileForm(request.POST, instance=client_profile)
        if client_profile_form.is_valid():
            client_profile_form.save()
        return HttpResponseRedirect('/client/profile/{0}'.format(pk))

class ClientPositionDesign(View):
    template = 'client/design.html'

    def get(self, request, order_id, position_id):
        position = Order.objects.get(id=position_id)
        position.mark_designer = False
        position.save()
        try: 
            img1 = Design1.objects.get(position=Order.objects.get(id=position_id))
        except:
            img1 = ""
        try: 
            img2 = Design2.objects.get(position=Order.objects.get(id=position_id))
        except:
            img2 = ""
        try: 
            img3 = Design3.objects.get(position=Order.objects.get(id=position_id))
        except:
            img3 = ""
        try: 
            img4 = Design4.objects.get(position=Order.objects.get(id=position_id))
        except:
            img4 = ""
        context = {
            'file_upload_form': FilesForChatForm(),               # Файлы для чата
            'files': FilesForChat.objects.filter(order=order_id), # Файлы для чата
            'design_img1': img1,
            'design_img2': img2,
            'design_img3': img3,
            'design_img4': img4,
            'active_home': 'active',
            'position': position,
            'position_chat': NewChatPosition.objects.filter(position=position_id),
        }
        return render(request, self.template, context)

    # Почемаем клиентом что есть изменения
    def mark_client(self, id):
        order_id = OrderNumber.objects.get(id=id)
        order_id.mark_client = True
        order_id.save()

    def post(self, request, order_id, position_id):
        self.mark_client(id=order_id)
        order = Order.objects.get(id=position_id)
        order.mark_client = True
        order.save()
        files_for_chat = FilesForChatForm(request.POST, request.FILES) # Файлы для чата
        if files_for_chat.is_valid():                                  # Файлы для чата
            s = files_for_chat.save(commit=False)                      # Файлы для чата
            s.order = OrderNumber.objects.get(id=order_id)             # Файлы для чата
            s.user = request.user                                      # Файлы для чата
            s.save()                                                   # Файлы для чата
        if 'img1_to_chat' in request.POST:
            comment = NewChatPosition()
            design = Design1.objects.get(position=Order.objects.get(id=position_id))
            comment.image = design.picture
            comment.user = auth.get_user(request)
            comment.position = Order.objects.get(id=position_id)
            comment.save()
        if 'img2_to_chat' in request.POST:
            comment = NewChatPosition()
            design = Design2.objects.get(position=Order.objects.get(id=position_id))
            comment.image = design.picture
            comment.user = auth.get_user(request)
            comment.position = Order.objects.get(id=position_id)
            comment.save()
        if 'img3_to_chat' in request.POST:
            comment = NewChatPosition()
            design = Design3.objects.get(position=Order.objects.get(id=position_id))
            comment.image = design.picture
            comment.user = auth.get_user(request)
            comment.position = Order.objects.get(id=position_id)
            comment.save()
        if 'img4_to_chat' in request.POST:
            comment = NewChatPosition()
            design = Design4.objects.get(position=Order.objects.get(id=position_id))
            comment.image = design.picture
            comment.user = auth.get_user(request)
            comment.position = Order.objects.get(id=position_id)
            comment.save()
        if 'confirm_1' in request.POST:
            design = Design1.objects.get(position=Order.objects.get(id=position_id))
            design.confirm = True
            design.save()
        if 'confirm_2' in request.POST:
            design = Design2.objects.get(position=Order.objects.get(id=position_id))
            design.confirm = True
            design.save()
        if 'confirm_3' in request.POST:
            design = Design3.objects.get(position=Order.objects.get(id=position_id))
            design.confirm = True
            design.save()
        if 'confirm_4' in request.POST:
            design = Design4.objects.get(position=Order.objects.get(id=position_id))
            design.confirm = True
            design.save()
        return HttpResponseRedirect(request.path)
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

class Logist(View):
    template = 'logist/logist.html'

    @method_decorator(permission_required('auth.logist_rw'))
    def get(self, request):
        context = {
            'active_home': 'active',
        }
        return render(request, self.template, context)


class Logist_orders(View):
    template = 'logist/orders.html'

    @method_decorator(permission_required('auth.logist_rw'))
    def get(self, request, status):
        try:
            if status == "done":
                orders = OrderNumber.objects.filter(status_done=True)
            else:
                orders = OrderNumber.objects.filter(status_done=False)
        except:
            orders = ""
        context = {
            'active_home': 'active',
            'orders': orders,
        }
        return render(request, self.template, context)


class ShippingCompanies(View):
    template = 'logist/shipping_companies.html'

    @method_decorator(permission_required('auth.logist_rw'))
    def get(self, request):
        logistics_companies = LogisticsCompanies.objects.all()
        context = {
            'active_shipping': 'active',
            'companies': logistics_companies,
        }
        return render(request, self.template, context)


class ShippingCompanies_add(View):
    template = 'logist/add_company.html'

    @method_decorator(permission_required('auth.logist_rw'))
    def get(self, request):
        form = LogistForm()
        context = {
            'form': form,
        }
        return render(request, self.template, context)

    @method_decorator(permission_required('auth.logist_rw'))
    def post(self, request):
        form = LogistForm(request.POST)
        if form.is_valid():
            form.save()
        return HttpResponseRedirect('/logist/shipping')


class ShippingCompanies_delete(View):

    @method_decorator(permission_required('auth.logist_rw'))
    def get(self, request, pk):
        LogisticsCompanies.objects.get(id=pk).delete()
        return HttpResponseRedirect('/logist/shipping')


class LogistOrderEdit(View):
    template = 'logist/logist_order_edit.html'

    # Логист ознакамливается с изменениями
    def mark_client(self, id):
        order_id = OrderNumber.objects.get(id=id)
        order_id.mark_client_for_logist = False
        order_id.save()

    @method_decorator(permission_required('auth.logist_rw'))
    def get(self, request, pk):
        self.mark_client(id=pk)
        order_id = OrderNumber.objects.get(id=pk)
        order = Order.objects.filter(order=order_id).order_by('id')
        order_edit = AddDocForm()
        docs = OrderDocuments.objects.filter(order=order_id)
        comments = OrderComment.objects.filter(order=order_id)
        logist_price = LogistPriceForm(instance=order_id)
        context = {
            'file_upload_form': FilesForChatForm(),               # Файлы для чата
            'files': FilesForChat.objects.filter(order=pk), # Файлы для чата
            'active_home': 'active',
            'order_id': order_id,
            'order': order,
            'docs': docs,
            'comments': comments,
            'order_edit': order_edit,
            'summary': OrderNumber.objects.summary(pk),
            'delivery_plan': OrderNumber.objects.calculate_plan_of_delivery(pk),
            'difference': OrderNumber.objects.logist_difference(pk),
            'logist_price': OrderNumber.objects.logist_price(pk),
            'logist_price_form': logist_price,
            'order_chat': NewChatOrder.objects.filter(order=order_id),
        }
        return render(request, self.template, context)

    # Логист помечает что есть изменения
    def mark_manager(self, id):
        order_id = OrderNumber.objects.get(id=id)
        order_id.mark_logist = True
        order_id.save()

    @method_decorator(permission_required('auth.logist_rw'))
    def post(self, request, pk):
        files_for_chat = FilesForChatForm(request.POST, request.FILES) # Файлы для чата
        if files_for_chat.is_valid():                                  # Файлы для чата
            s = files_for_chat.save(commit=False)                      # Файлы для чата
            s.order = OrderNumber.objects.get(id=pk)                   # Файлы для чата
            s.user = request.user                                      # Файлы для чата
            s.save()                                                   # Файлы для чата
        if 'docs' in request.POST:
            docs = AddDocForm(request.POST, request.FILES)
            if docs.is_valid():
                doc = OrderDocuments()
                doc.title = docs.cleaned_data['title']
                doc.discription = docs.cleaned_data['discription']
                doc.file = docs.cleaned_data['file']
                doc.order = OrderNumber.objects.get(id=pk)
                doc.save()
        if 'add_comment' in request.POST:
            comment = OrderComment()
            comment.comment = request.POST['comment']
            comment.order = OrderNumber.objects.get(id=pk)
            comment.user = auth.get_user(request)
            comment.save()
        if 'delivery_price' in request.POST:
            order = OrderNumber.objects.get(id=pk)
            order.logist_delivering = request.POST['logist_delivering']
            order.save()
        return HttpResponseRedirect('/logist/orders/edit/{0}'.format(pk))


class LogistOrderEdit_change(View):
    template = 'logist/logist_order_edit_change.html'
    logist_formset = modelformset_factory(Order, fields=('id', 'shipping_company', 'weight', 'volume', 'est_date', 'sending_date', 'delivering_price'), 
        widgets={
                    'id': forms.TextInput(attrs={'type': 'hidden'}), 
                    'shipping_company': forms.Select(attrs={'class': 'form-control input-sm'}),
                    'weight': forms.NumberInput(attrs={'class': 'form-control input-sm'}), 
                    'volume': forms.NumberInput(attrs={'class': 'form-control input-sm'}),
                    'delivering_price': forms.NumberInput(attrs={'class': 'form-control input-sm'}),
                    'est_date': forms.DateInput(format=('%Y-%m-%d'), attrs={'class': 'form-control input-sm', 'type': 'date'}),
                    'sending_date': forms.DateInput(format=('%Y-%m-%d'), attrs={'class': 'form-control input-sm', 'type': 'date'}),
                })

    @method_decorator(permission_required('auth.logist_rw'))
    def get(self, request, pk):
        order_id = OrderNumber.objects.get(id=pk)
        order = Order.objects.filter(order=order_id).order_by('id')
        formset = self.logist_formset(queryset=Order.objects.filter(order=order_id).order_by('id'))
        new_order = []
        l = 0
        for i in order:
            new_formset = {}
            new_formset['id']=i.id
            new_formset['item']=i.item
            new_formset['size']=i.size
            new_formset['app_method']=i.app_method
            new_formset['material']=i.material
            new_formset['quantity']=i.quantity
            new_formset['price']=i.price
            new_formset['summary']=i.summary
            new_formset['provider']=i.provider
            new_formset['post_payment']=i.post_payment
            new_formset['pre_payment']=i.pre_payment
            new_formset['logist']=formset[l]
            new_order.append(new_formset)
            l = l + 1
        context = {
            'active_home': 'active',
            'order_id': order_id,
            'order': new_order,
            'formset': formset,  
        }
        return render(request, self.template, context)

    @method_decorator(permission_required('auth.logist_rw'))
    def post(self, request, pk):
        formset = self.logist_formset(request.POST)
        if formset.is_valid():
            fs = formset.save()
        return HttpResponseRedirect('/logist/orders/edit/{0}'.format(pk))


class LogistOrderEdit_change_status(View):
    template = ''

    @method_decorator(permission_required('auth.logist_rw'))
    def get(self, request, pk):
        pass

    @method_decorator(permission_required('auth.logist_rw'))
    def post(self, request, pk):
        pass


class DeliveryInfo(View):
    template = 'logist/delivery_info.html'

    @method_decorator(permission_required('auth.logist_rw'))
    def get(self, request, order_pk, position_pk):
        position_info = Order.objects.get(id=position_pk)
        order_id = OrderNumber.objects.get(id=order_pk)
        context = {
            'active_home': 'active',
            'order_id': order_id,
            'position_info': position_info,
        }
        return render(request, self.template, context)


class LogistLinks(View):
    template = 'logist/links.html'

    @method_decorator(permission_required('auth.logist_rw'))
    def get(self, request):
        links = LogistLink.objects.all()
        add_link_form = LogistLinkForm()
        context = {
            'links': links,
            'add_link': add_link_form,
            'active_links': 'active',
        }
        return render(request, self.template, context)

    @method_decorator(permission_required('auth.logist_rw'))
    def post(self, request):    
        add_link_form = LogistLinkForm(request.POST)
        if add_link_form.is_valid():
            add_link_form.save()
        return HttpResponseRedirect(request.path)


class LinkDelete(View):

    @method_decorator(permission_required('auth.logist_rw'))
    def get(self, request, pk):
        LogistLink.objects.get(id=pk).delete()
        return HttpResponseRedirect('/logist/links')


class LogistClients(View):
    template = 'logist/clients.html'

    @method_decorator(permission_required('auth.logist_rw'))
    def get(self, request,):
        clients_list = ClientProfile.objects.filter(client_type=2)
        context = {
            'clients_list': clients_list,
            'active_clients': 'active',
        }
        return  render(request, self.template, context)


class LogistClientData(View):
    template = 'logist/client_data.html'

    @method_decorator(permission_required('auth.logist_rw'))
    def get(self, request, pk):
        client_docs_form = ClientDocumentsForm()
        client_brand_form = ClientBrandbookForm()
        client_profile = ClientProfile.objects.get(id=pk)
        client_docs = ClientDocuments.objects.filter(client=client_profile)
        contract_attached_form = ContactAttachedForm(instance=client_profile)
        brandbook_docs = ClientBrandbook.objects.filter(client=client_profile)
        try:
            client_account = User.objects.get(id=client_profile.user.id)
        except:
            client_account = False
        context = {
            'contract_attached': contract_attached_form,
            'active_clients': 'active',
            'client_account': client_account,
            'client_profile': client_profile,
            'docs': client_docs_form,
            'client_docs': client_docs,
            'brandbook': client_brand_form,
            'client_brandbook': brandbook_docs,
        }
        return render(request, self.template, context)

    @method_decorator(permission_required('auth.logist_rw'))
    def post(self, request, pk):
        if request.POST.get('add_file', 'no') == 'yes':
            client_docs_form = ClientDocumentsForm(request.POST, request.FILES)
            if client_docs_form.is_valid():
                docs = client_docs_form.save(commit=False)
                docs.client = ClientProfile.objects.get(id=pk)
                docs.save()
                return HttpResponseRedirect('/logist/client/{0}'.format(pk))
        if request.POST.get('add_brand', 'no') == 'yes':
            client_brand_form = ClientBrandbookForm(request.POST, request.FILES)
            if client_brand_form.is_valid():
                docs = client_brand_form.save(commit=False)
                docs.client = ClientProfile.objects.get(id=pk)
                docs.save()
                return HttpResponseRedirect('/logist/client/{0}'.format(pk))
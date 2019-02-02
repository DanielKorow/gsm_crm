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


class Manager(View):

    template = 'manager/manager.html'


    @method_decorator(permission_required('auth.manager_rw'))
    def get(self, request):
        context = {

        }
        return  render(request, self.template, context)


    @method_decorator(permission_required('auth.manager_rw'))
    def post(self, request):
        pass


class Clients(View):

    template = 'manager/clients.html'


    @method_decorator(permission_required('auth.manage_clients'))
    def get(self, request, client_type):
        if client_type == 'enterprise':
            link = 'enterprise'
            clients_list = ClientProfile.objects.filter(client_type=2)
        if client_type == 'individual':
            link = 'individual'
            clients_list = ClientProfile.objects.filter(client_type=1)
        context = {
            'link': link,
            'clients_list': clients_list,
            'active_clients': 'active',
        }
        return  render(request, self.template, context)


    @method_decorator(permission_required('auth.manage_clients'))
    def post(self, request):
        pass


class CreateClientProfile(View):

    template = 'manager/create_client.html'


    @method_decorator(permission_required('auth.manage_clients'))
    def get(self, request, client_type):
        create_client_enterprise = False
        create_client_individual = False
        if client_type == 'enterprise':
            create_client_enterprise = CreateClientForm()
        if client_type == 'individual':
            create_client_individual = CreateIndividualClientForm()
        context = {
            'active_clients': 'active',
            'create_client_enterprise': create_client_enterprise,
            'create_client_individual': create_client_individual,
        }
        return  render(request, self.template, context) 


    @method_decorator(permission_required('auth.manage_clients'))
    def post(self, request, client_type):
        if client_type == 'enterprise':
            create_client = CreateClientForm(request.POST)
            if create_client.is_valid():
                replace_text = create_client.cleaned_data['requisites'].replace('\n\r', '<br> ')
                replace_text = create_client.cleaned_data['requisites'].replace('\n', '<br> ')
                client = ClientProfile(company=create_client.cleaned_data['company_name'], surname=create_client.cleaned_data['surname'], 
                    first_name=create_client.cleaned_data['first_name'], middle_name=create_client.cleaned_data['middle_name'], email=create_client.cleaned_data['email'],
                    client_type=2, requisites=replace_text, phone=create_client.cleaned_data['phone'], delivery_address=create_client.cleaned_data['delivery_address'])
                client.save()
            if request.POST.get('create_account', False):
                return HttpResponseRedirect('/manager/create_client_account/{0}'.format(client.id))
            return HttpResponseRedirect('/manager/clients/enterprise')
        if client_type == 'individual':
            create_client = CreateIndividualClientForm(request.POST)
            if create_client.is_valid():
                client = ClientProfile(surname=create_client.cleaned_data['surname'], first_name=create_client.cleaned_data['first_name'], 
                    middle_name=create_client.cleaned_data['middle_name'], email=create_client.cleaned_data['email'],
                    client_type=1, company=create_client.cleaned_data['surname'] + " " + create_client.cleaned_data['first_name'] + " " + create_client.cleaned_data['middle_name'])
                client.save()
            if request.POST.get('create_account', False):
                return HttpResponseRedirect('/manager/create_client_account/{0}'.format(client.id))
            return HttpResponseRedirect('/manager/clients/individual')


class CreateClientAccount(View):

    template = 'manager/create_client_account.html'


    @method_decorator(permission_required('auth.manage_clients'))
    def get(self, request, pk):
        create_client_account = CreateClientAccountForm()
        context = {
            'active_clients': 'active',
            'create_client_account': create_client_account,
        }
        return render(request, self.template, context)


    @method_decorator(permission_required('auth.manage_clients'))
    def post(self, request, pk):
        create_client_account = CreateClientAccountForm(request.POST)
        if create_client_account.is_valid():
            client_profile = ClientProfile.objects.get(id=pk)
            # Создать случайны пароль
            password_random = User.objects.make_random_password()
            client_account = User.objects.create_user(create_client_account.cleaned_data['email'], 
                create_client_account.cleaned_data['email'], password_random,
                first_name=client_profile.first_name + " " + client_profile.middle_name, last_name=client_profile.surname)
            client_profile.user = client_account
            client_profile.save()
            content_type = ContentType.objects.get_for_model(User)
            clients = Group.objects.get(name='Clients')
            client_account.groups.add(clients)
            try:
                send_mail('Ваш аккаунт создан',
                    'Для входа перейдите по адресу: http://client.gsmagency.ru \nЛогин: {0} \nПароль: {1}'.format(create_client_account.cleaned_data['email'], password_random), 
                    'info@gsmagency.ru', [create_client_account.cleaned_data['email']])
            except:
                pass
            return HttpResponseRedirect('/manager/clients/enterprise')


class ClientProfileManager(View):

    template = 'manager/client_profile.html'


    @method_decorator(permission_required('auth.manage_clients'))
    def get(self, request, pk):
        client_docs_form = ClientDocumentsForm()
        client_brand_form = ClientBrandbookForm()
        client_profile = ClientProfile.objects.get(id=pk)
        client_docs = ClientDocuments.objects.filter(client=client_profile)
        brandbook_docs = ClientBrandbook.objects.filter(client=client_profile)
        contract_attached_form = ContactAttachedForm(instance=client_profile)
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
            'client_brandbook': brandbook_docs,
            'client_docs': client_docs,
            'brandbook': client_brand_form,
        }
        return render(request, self.template, context)


    @method_decorator(permission_required('auth.manage_clients'))
    def post(self, request, pk):
        if request.POST.get('delete_account', 'no') == 'yes':
                id_client = ClientProfile.objects.get(id=request.POST['id'])
                User.objects.get(id=id_client.user.id).delete()
                return HttpResponseRedirect('/manager/clients/enterprise')
        if request.POST.get('delete_client', 'no') == 'yes':
            try:
                id_client = ClientProfile.objects.get(id=request.POST['id'])
                User.objects.get(id=id_client.user.id).delete()
                profile = ClientProfile.objects.get(id=request.POST['id']).delete()
                return HttpResponseRedirect('/manager/clients/enterprise')
            except:
                id_client = ClientProfile.objects.get(id=request.POST['id']).delete()
                return HttpResponseRedirect('/manager/clients/enterprise')
        if request.POST.get('create_account', 'no') == 'yes':
                return HttpResponseRedirect('/manager/create_client_account/{0}'.format(pk))
        if request.POST.get('add_file', 'no') == 'yes':
            client_docs_form = ClientDocumentsForm(request.POST, request.FILES)
            if client_docs_form.is_valid():
                docs = client_docs_form.save(commit=False)
                docs.client = ClientProfile.objects.get(id=pk)
                docs.save()
                return HttpResponseRedirect('/manager/client_profile/{0}'.format(pk))
        if 'contract_att' in request.POST:
            client_profile = ClientProfile.objects.get(id=pk)
            contract_attached_form = ContactAttachedForm(request.POST, instance=client_profile)
            if contract_attached_form.is_valid():
                contract_attached_form.save()
                return HttpResponseRedirect('/manager/client_profile/{0}'.format(pk))
        if request.POST.get('add_brand', 'no') == 'yes':
            client_brand_form = ClientBrandbookForm(request.POST, request.FILES)
            if client_brand_form.is_valid():
                docs = client_brand_form.save(commit=False)
                docs.client = ClientProfile.objects.get(id=pk)
                docs.save()
                return HttpResponseRedirect('/manager/client_profile/{0}'.format(pk))



class Items(View):

    template = 'manager/items.html'

    def get(self, request):
        items = Item.objects.all()
        context = {
            'items': items,
            'active_items': 'active'
        }
        return render(request, self.template, context)

    def post(seld, request):
        pass


class Add_item(View):

    template = 'manager/add_item.html'

    @method_decorator(permission_required('auth.manage_clients'))
    def get(self, request):
        items_form = ItemsForm()
        context = {
            'items_form': items_form,
        }
        return render(request, self.template, context)


    @method_decorator(permission_required('auth.manage_clients'))
    def post(self, request):
        items_form = ItemsForm(request.POST, request.FILES)
        items_form.save()
        return HttpResponseRedirect('/manager/items')


class Remove_item(View):

    @method_decorator(permission_required('auth.manage_clients'))
    def get(self, request, pk):
        Item.objects.get(id=pk).delete()
        return HttpResponseRedirect('/manager/items')


class ApplicationMethods(View):

    template = 'manager/application_methods.html'

    @method_decorator(permission_required('auth.manage_clients'))
    def get(self, request):
        app_methods = ApplicationMethod.objects.all()
        context = {
            'app_methods': app_methods,
            'active_application': 'active',
        }
        return render(request, self.template, context)


class ApplicationMethods_add(View):

    template = 'manager/add_method.html'

    @method_decorator(permission_required('auth.manage_clients'))
    def get(self, request):
        app_form = AppMethodForm()
        context = {
            'app_form': app_form,
        }
        return render(request, self.template, context)

    @method_decorator(permission_required('auth.manage_clients'))
    def post(self, request):
        app_form = AppMethodForm(request.POST)
        app_form.save()
        return HttpResponseRedirect('/manager/application_methods')


class ApplicationMethods_remove(View):

    @method_decorator(permission_required('auth.manage_clients'))
    def get(self, request, pk):
        ApplicationMethod.objects.get(id=pk).delete()
        return HttpResponseRedirect('/manager/application_methods')


class Materials_view(View):

    template = 'manager/materials.html'

    @method_decorator(permission_required('auth.manage_clients'))
    def get(self, request):
        materials = Materials.objects.all()
        context = {
                'materials': materials,
                'active_materials': 'active',
            }
        return render(request, self.template, context)


class Materials_add(View):

    template = 'manager/add_materials.html'

    @method_decorator(permission_required('auth.manage_clients'))
    def get(self, request):
        materials_form = MaterialsForm()
        context = {
            'materials_form': materials_form,
            'active_materials': 'active',
        }
        return render(request, self.template, context)

    @method_decorator(permission_required('auth.manage_clients'))
    def post(self, request):
        materials_form = MaterialsForm(request.POST)
        materials_form.save()
        return HttpResponseRedirect('/manager/materials')


class Materials_remove(View):

    @method_decorator(permission_required('auth.manage_clients'))
    def get(self, request, pk):
        Materials.objects.get(id=pk).delete()
        return HttpResponseRedirect('/manager/materials')


class Orders(View):

    template = 'manager/orders.html'

    @method_decorator(permission_required('auth.manage_clients'))
    def get(self, request, status):
        try:
            if status == "done":
                orders = OrderNumber.objects.filter(status_done=True)
            else:
                orders = OrderNumber.objects.filter(status_done=False)
        except:
            orders = ""
        select_client = ClientsForm()
        context = {
            'orders': orders,
            'select_client': select_client,
            'active_orders': 'active',
        }
        return render(request, self.template, context)

    @method_decorator(permission_required('auth.manage_clients'))
    def post(self, request, status):
        pass


class Get_order_url(View):

    def post(self, request):
        pk=request.POST['clients']
        return HttpResponseRedirect('/manager/orders/add/{0}'.format(pk))


class Orders_add(View):

    template = 'manager/add_order.html'

    @method_decorator(permission_required('auth.manage_clients'))
    def get(self, request, pk):
        client = ClientProfile.objects.get(id=pk)
        add_item_form = AddOrdersForm()
        manager = auth.get_user(request)
        cart = Cart_(request)
        context = {
                'active_orders': 'active',
                'manager': manager,
                'cart': cart.get_cart(client),
                'add_item': add_item_form,
                'client': client,
            }
        return render(request, self.template, context)

    @method_decorator(permission_required('auth.manage_clients'))
    def post(self, request, pk):
        if 'add' in request.POST:
            cart = Cart_(request)
            client = ClientProfile.objects.get(id=pk)
            item = Item.objects.get(id=request.POST['item'])
            app_method = ApplicationMethod.objects.get(id=request.POST['app_method'])
            # size = Size.objects.get(id=request.POST['size'])
            material = Materials.objects.get(id=request.POST['material'])
            cart.add(item, app_method, client, material, request.POST['price'], request.POST['pre_payment'], request.POST['info'], request.POST['quantity'])
        if 'save' in request.POST:
            client = ClientProfile.objects.get(id=pk)
            cart = Cart_(request)
            cart_to_save = cart.get_cart(client)
            manager_to_table = auth.get_user(request)
            order = OrderNumber(client=client, user=manager_to_table)
            order.save()
            save_list = []
            status = OrderStatus.objects.add_status()
            for i in cart_to_save:
                save_order = Order()
                save_order.status = status
                save_order.client = client
                save_order.manager = manager_to_table
                save_order.order = order
                save_order.item = i.item
                # save_order.size = i.size
                save_order.info = i.info
                save_order.material = i.material
                save_order.app_method = i.app_method
                save_order.quantity = i.quantity
                save_order.price = i.price
                save_order.pre_payment = i.pre_payment
                save_list.append(save_order)
            Order.objects.bulk_create(save_list)
            designer_order = []
            for i in save_list:
                position = (i.item, i.material, i.app_method)
                if position in designer_order:
                    pass
                else:
                    designer_order.append(position)
            save_list = []
            for i in designer_order:
                save_designer_order = DesignerOrder()
                save_designer_order.item = i[0]
                save_designer_order.material = i[1]
                save_designer_order.app_method = i[2]
                save_list.append(save_designer_order)
            DesignerOrder.objects.bulk_create(save_list)
            cart.clear()
        return HttpResponseRedirect(request.path)
        

class Position_remove(View):

    @method_decorator(permission_required('auth.manage_clients'))
    def get(self, request, client, pk):
        cart = Cart_(request)
        cart.remove_position(pk)
        return HttpResponseRedirect('/manager/orders/add/{0}'.format(client))


class OrderPosition_remove(View):

    @method_decorator(permission_required('auth.manage_clients'))
    def get(self, request, order_number,  pk):
        Order.objects.get(id=pk).delete()
        return HttpResponseRedirect('/manager/orders/edit/{0}'.format(order_number))


class Orders_edit(View):

    template = 'manager/edit_order.html'

    @method_decorator(permission_required('auth.manage_clients'))
    def get(self, request, pk):
        order_id = OrderNumber.objects.get(id=pk)
        order = Order.objects.filter(order=order_id)
        order_edit = AddDocForm()
        docs = OrderDocuments.objects.filter(order=order_id)
        comments = OrderComment.objects.filter(order=order_id)
        adding_cost = ManagerAddingCostForm(instance=order_id)
        addagr = AddAgrForm(instance=order_id)
        context = {
            'active_orders': 'active',
            'order_id': order_id,
            'order_edit': order_edit,
            'order': order,
            'docs': docs,
            'adding_cost': adding_cost,
            'comments': comments,
            'summary': OrderNumber.objects.summary(pk),
            'pre_payment': OrderNumber.objects.pre_payment(pk),
            'post_payment': OrderNumber.objects.post_payment(pk),
            'summary_entry': OrderNumber.objects.summary_entry(pk),
            'order_margin': OrderNumber.objects.order_margin(pk),
            'summary_with_adding': OrderNumber.objects.summary_with_adding(pk),
            'logist_motivation': OrderNumber.objects.calculate_plan_of_delivery(pk),
            'production_motivation': OrderNumber.objects.production_motivation(pk),
            'designer_motivation': OrderNumber.objects.calculate_designer_motivation(pk),
            'logist_fact': OrderNumber.objects.logist_price(pk),
            'addagr_form': addagr,
        }
        return render(request, self.template, context)


    @method_decorator(permission_required('auth.manage_clients'))
    def post(self, request, pk):
        if 'docs' in request.POST:
            docs = AddDocForm(request.POST, request.FILES)
            if docs.is_valid():
                doc = OrderDocuments()
                doc.title = docs.cleaned_data['title']
                doc.discription = docs.cleaned_data['discription']
                doc.file = docs.cleaned_data['file']
                doc.order = OrderNumber.objects.get(id=pk)
                doc.save()
        if 'adding_cost' in request.POST:
            adding_cost = ManagerAddingCostForm(request.POST, instance=OrderNumber.objects.get(id=pk))
            if adding_cost.is_valid():
                adding_cost.save()
        if 'add_comment' in request.POST:
            comment = OrderComment()
            comment.comment = request.POST['comment']
            comment.order = OrderNumber.objects.get(id=pk)
            comment.user = auth.get_user(request)
            comment.save()
        if 'add_agr' in request.POST:
            addagr = AddAgrForm(request.POST, instance=OrderNumber.objects.get(id=pk))
            if addagr.is_valid():
                addagr.save()
        return HttpResponseRedirect(request.path)


class Change_order(View):

    template = 'manager/change_order.html'
    order_formset = modelformset_factory(Order, fields=('id', 'price', 'pre_payment', 'quantity' , 'info', 'production_purchase_price'), 
        widgets={
                    'id': forms.TextInput(attrs={'type': 'hidden'}),
                    'price': forms.NumberInput(attrs={'class': 'form-control'}), 
                    'pre_payment': forms.NumberInput(attrs={'class': 'form-control', 'required': ''}), 
                    'quantity': forms.NumberInput(attrs={'class': 'form-control'}),
                    'info': forms.TextInput(attrs={'class': 'form-control'}),
                    'production_purchase_price': forms.NumberInput(attrs={'class': 'form-control'}),
                })

    @method_decorator(permission_required('auth.manage_clients'))
    def get(self, request, pk):
        order_id = OrderNumber.objects.get(id=pk)
        order = Order.objects.filter(order=order_id).order_by('id')
        formset = self.order_formset(queryset=Order.objects.filter(order=order_id))
        new_order = []
        l = 0
        for i in order:
            new_formset = {}
            new_formset['id']=i.id
            new_formset['item']=i.item
            new_formset['size']=i.size
            new_formset['app_method']=i.app_method
            new_formset['material']=i.material
            new_formset['production_purchase_price']=i.production_purchase_price
            new_formset['summary']=i.summary
            new_formset['summary_entry']=i.summary_entry
            new_formset['post_payment']=i.post_payment
            new_formset['provider']=i.provider
            new_formset['production_status']=i.production_status
            new_formset['price']=formset[l]
            new_order.append(new_formset)
            l = l + 1
        context = {
            'active_orders': 'active',
            'order_id': order_id,
            'formset': formset,
            'order': new_order,
            'summary': OrderNumber.objects.summary(pk),
            'pre_payment': OrderNumber.objects.pre_payment(pk),
            'post_payment': OrderNumber.objects.post_payment(pk),
        }
        return render(request, self.template, context)

    @method_decorator(permission_required('auth.manage_clients'))
    def post(self, request, pk):
        formset = self.order_formset(request.POST)
        if 'save' in request.POST:
            if formset.is_valid():
                formset.save()
        return HttpResponseRedirect('/manager/orders/edit/{0}'.format(pk))

class ManagerOrderDone(View):
    def get(self, request, pk):
        order = OrderNumber.objects.get(id=pk)
        order.status_done = True
        order.save()
        return HttpResponseRedirect('/manager/orders/done')


class Manager_providers(View):
    template = 'manager/providers.html'
    
    @method_decorator(permission_required('auth.manage_clients'))
    def get(self, request):
        providers = Provider.objects.all()
        context = {
            'active_providers': 'active',
            'providers': providers,
        }
        return render(request, self.template, context)

    def post(self, request):
        pass


class Manager_logistic_companies(View):
    template = 'manager/logistic_companies.html'

    @method_decorator(permission_required('auth.manage_clients'))
    def get(self, request):
        logistics_companies = LogisticsCompanies.objects.all()
        context = {
            'active_shipping': 'active',
            'companies': logistics_companies,
        }
        return render(request, self.template, context)

    def post(self, request):
        pass


class ManagerDesign(View):
    template = 'manager/design_order.html'

    @method_decorator(permission_required('auth.manage_clients'))
    def get(self, request, pk):
        order_id = OrderNumber.objects.get(id=pk)
        order = Order.objects.filter(order=order_id).order_by('id')
        context = {
            'order_id': order_id,
            'active_orders': 'active',
            'order': order,
            'order_comment': OrderComment.objects.filter(order=order_id),
        }
        return render(request, self.template, context)

    @method_decorator(permission_required('auth.manage_clients'))
    def post(self, request, pk):
        if 'add_order_comment' in request.POST:
            comment = OrderComment()
            comment.comment = request.POST['comment']
            comment.order = OrderNumber.objects.get(id=pk)
            comment.user = auth.get_user(request)
            comment.save()
        return HttpResponseRedirect(request.path)


class ManagerPositionDesign(View):
    template = 'manager/design_order.html'

    design_formset = modelformset_factory(DesignImage, fields=('id', 'image', 'confirm', 'position'), extra=1, 
        widgets={
                'id': forms.TextInput(attrs={'type': 'hidden'}),
                    })

    @method_decorator(permission_required('auth.manage_clients'))
    def get(self, request, order_pk, position_pk):
        order_id = OrderNumber.objects.get(id=order_pk)
        order = Order.objects.filter(order=order_id).order_by('id')
        formset = self.design_formset(queryset=DesignImage.objects.filter(position=Order.objects.get(id=position_pk)))
        comments = DesignImageComment.objects.filter(position=Order.objects.get(id=position_pk))
        try:
            design1 = Design1Form(instance=Design1.objects.get(position=Order.objects.get(id=position_pk)))
        except:
            design1 = Design1Form()
        try:
            design2 = Design2Form(instance=Design2.objects.get(position=Order.objects.get(id=position_pk)))
        except:
            design2 = Design2Form()
        try:
            design3 = Design3Form(instance=Design3.objects.get(position=Order.objects.get(id=position_pk)))
        except:
            design3 = Design3Form()
        try:
            design4 = Design4Form(instance=Design4.objects.get(position=Order.objects.get(id=position_pk)))
        except:
            design4 = Design4Form()
        upload_design = UploadDesign()
        try: 
            img1 = Design1.objects.get(position=Order.objects.get(id=position_pk))
        except:
            img1 = ""
        try: 
            img2 = Design2.objects.get(position=Order.objects.get(id=position_pk))
        except:
            img2 = ""
        try: 
            img3 = Design3.objects.get(position=Order.objects.get(id=position_pk))
        except:
            img3 = ""
        try: 
            img4 = Design4.objects.get(position=Order.objects.get(id=position_pk))
        except:
            img4 = ""
        context = {
            'order_id': order_id,
            'active_orders': 'active',
            'order': order,
            'upload_design': upload_design,
            'design': formset,
            'comments': comments,
            'design1': design1,
            'design2': design2,
            'design3': design3,
            'design4': design4,
            'design_img1': img1,
            'design_img2': img2,
            'design_img3': img3,
            'design_img4': img4,
            'order_comment': OrderComment.objects.filter(order=order_id),
        }
        return render(request, self.template, context)

    @method_decorator(permission_required('auth.manage_clients'))
    def post(self, request, order_pk, position_pk):
        if 'add_comment' in request.POST:
            comment = DesignImageComment()
            comment.comment = request.POST['comment']
            comment.user = auth.get_user(request)
            comment.position = Order.objects.get(id=position_pk)
            comment.save()
        if 'add_order_comment' in request.POST:
            comment = OrderComment()
            comment.comment = request.POST['comment']
            comment.order = OrderNumber.objects.get(id=order_pk)
            comment.user = auth.get_user(request)
            comment.save()
        return HttpResponseRedirect(request.path)


class Production(View):

    template = 'production/order.html'

    @method_decorator(permission_required('auth.production_rw'))
    def get(self, request):
        context = {
            'active_home': 'active',
        }
        return render(request, self.template, context)

    @method_decorator(permission_required('auth.production_rw'))
    def post(self, request):
        pass


class Production_orders(View):

    template = 'production/orders.html'

    @method_decorator(permission_required('auth.production_rw'))
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

    @method_decorator(permission_required('auth.production_rw'))
    def post(self, request, status):
        pass


class Providers(View):

    template = 'production/providers.html'

    @method_decorator(permission_required('auth.production_rw'))
    def get(self, request):
        providers = Provider.objects.all()
        context = {
            'active_providers': 'active',
            'providers': providers,
        }
        return render(request, self.template, context)

    @method_decorator(permission_required('auth.production_rw'))
    def post(self, request):
        pass


class Providers_add(View):

    template = 'production/add_provider.html'

    @method_decorator(permission_required('auth.production_rw'))
    def get(self, request):
        provider_form = ProviderForm()
        
        context = {
            'active_providers': 'active',
            'form': provider_form,
        }
        return render(request, self.template, context)

    @method_decorator(permission_required('auth.production_rw'))
    def post(self, request):
        provider_form = ProviderForm(request.POST)
        provider_form.save()
        return HttpResponseRedirect('/production/providers')


class Providers_change(View):
    template = 'production/edit_provider.html'

    @method_decorator(permission_required('auth.production_rw'))
    def get(self, request, pk):
        provider = Provider.objects.get(id=pk)
        try:
            provider.requisites = provider.requisites.replace('<br> ', '\n')
        except:
            pass
        change_form = ProviderForm(instance=provider)
        doc_form = ProviderDocumentsForm()
        docs = ProviderDocuments.objects.filter(provider=provider)
        # replace_text = provider.requisites.replace('<br> ', '\n')
        # change_form = CreateClientForm(initial={'surname': provider.surname, 'first_name': provider.first_name, 'middle_name': provider.middle_name,
        #             'company_name': provider.title, 'email': provider.email, 'requisites': replace_text})
        context = {
            'docs': docs,
            'doc_form': doc_form,
            'active_providers': 'active',
            'form' : change_form,
        }
        return render(request, self.template, context)

    @method_decorator(permission_required('auth.production_rw'))    
    def post(self, request, pk):
        provider = Provider.objects.get(id=pk)
        if 'save' in request.POST:
            change_form = ProviderForm(request.POST, instance=provider)
            if change_form.is_valid():
                change_form.save()
        if 'add_file' in request.POST:
            doc_form = ProviderDocumentsForm(request.POST, request.FILES)
            if doc_form.is_valid():
                docs = doc_form.save(commit=False)
                docs.provider = provider
                docs.save()
            return HttpResponseRedirect('/production/providers/change/{0}'.format(pk))
        return HttpResponseRedirect('/production/providers')



class Production_orders_edit(View):

    template = 'production/edit_order.html'

    @method_decorator(permission_required('auth.production_rw'))
    def get(self, request, pk):
        order_id = OrderNumber.objects.get(id=pk)
        order = Order.objects.filter(order=order_id)
        order_edit = AddDocForm()
        docs = OrderDocuments.objects.filter(order=order_id)
        comments = OrderComment.objects.filter(order=order_id)
        order_status_form = OrderStatusForm(instance=order_id)
        context = {
            'active_home': 'active',
            'order_id': order_id,
            'prder_status_form': order_status_form,
            'order_edit': order_edit,
            'order': order,
            'docs': docs,
            'comments': comments,
            'summary': OrderNumber.objects.summary(pk),
            'pre_payment': OrderNumber.objects.pre_payment(pk),
            'post_payment': OrderNumber.objects.post_payment(pk),
            'production_motivation': OrderNumber.objects.production_motivation(pk),
        }
        return render(request, self.template, context)

    @method_decorator(permission_required('auth.production_rw'))
    def post(self, request, pk):
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
        if 'in_design' in request.POST:
            order_id = OrderNumber.objects.get(id=pk)
            order_id.status = 2
            order_id.save()
        if 'to_client' in request.POST:
            order_id = OrderNumber.objects.get(id=pk)
            order_id.status = 5
            order_id.save()
        if 'send_order_status' in request.POST:
            order_id = OrderNumber.objects.get(id=pk)
            order_status_form = OrderStatusForm(request.POST, instance=order_id)
            order_status_form.save()
        return HttpResponseRedirect(request.path)


class ProductionOrderEdit_change_provider(View):

    template = 'production/edit_order_add_provider.html'
    providers_formset = modelformset_factory(Order, fields=('id', 'provider', 'production_status', 'app_method', 
        'production_purchase_price', 'production_est_date', 'material',
        'design_specification_new', 'design_requirements_new', 'provider_pre_payment'), 
        widgets={
                    'id': forms.TextInput(attrs={'type': 'hidden'}), 
                    'provider': forms.Select(attrs={'class': 'form-control input-sm'}), 
                    'production_status': forms.Select(attrs={'class': 'form-control input-sm'}),
                    'app_method': forms.Select(attrs={'class': 'form-control input-sm'}),
                    'material': forms.Select(attrs={'class': 'form-control input-sm'}),
                    'production_purchase_price': forms.NumberInput(attrs={'class': 'form-control input-sm'}),
                    'design_specification_new': forms.Select(attrs={'class': 'form-control input-sm'}),
                    'design_requirements_new': forms.Select(attrs={'class': 'form-control input-sm'}),
                    'production_est_date': forms.DateInput(format=('%Y-%m-%d'), attrs={'class': 'form-control input-sm', 'type': 'date'}),
                })

    @method_decorator(permission_required('auth.production_rw'))
    def get(self, request, pk):
        order_id = OrderNumber.objects.get(id=pk)
        order = Order.objects.filter(order=order_id).order_by('id')
        formset = self.providers_formset(queryset=Order.objects.filter(order=order_id))
        new_order = []
        l = 0
        for i in order:
            new_formset = {}
            new_formset['id']=i.id
            new_formset['item']=i.item
            # new_formset['size']=i.size
            # new_formset['app_method']=i.app_method
            # new_formset['material']=i.material
            new_formset['quantity']=i.quantity
            new_formset['price']=i.price
            new_formset['summary']=i.summary
            new_formset['post_payment']=i.post_payment
            new_formset['pre_payment']=i.pre_payment
            new_formset['provider']=formset[l]
            new_order.append(new_formset)
            l = l + 1
        order_edit = AddDocForm()
        docs = OrderDocuments.objects.filter(order=order_id)
        comments = OrderComment.objects.filter(order=order_id)
        context = {
            'active_home': 'active',
            'order_id': order_id,
            'order_edit': order_edit,
            'order': new_order,
            'docs': docs,
            'comments': comments,
            'formset': formset,
            'summary': OrderNumber.objects.summary(pk),
            'pre_payment': OrderNumber.objects.pre_payment(pk),
            'post_payment': OrderNumber.objects.post_payment(pk),
        }
        return render(request, self.template, context)

    @method_decorator(permission_required('auth.production_rw'))
    def post(self, request, pk):
        formset = self.providers_formset(request.POST)
        if formset.is_valid():
            fs = formset.save()
            order_id = OrderNumber.objects.get(id=pk)
            order = Order.objects.filter(order=order_id).order_by('id')
            order_status = []
            for i in order:
                order_status.append(str(i.production_status))
            # if 'Дизайн' in order_status:
            #     order_id = OrderNumber.objects.get(id=pk)
            #     order_id.status = 2
            #     order_id.save()
            # else:
            #     order_id = OrderNumber.objects.get(id=pk)
            #     order_id.status = 1
            #     order_id.save()
        # return render(request, 'production/errors.html', {'errors': formset.errors})
        return HttpResponseRedirect('/production/orders/edit/{0}'.format(pk))


class ProductionDesign(View):
    template = "production/design_order.html"

    @method_decorator(permission_required('auth.production_rw'))
    def get(self, request, pk):
        order_id = OrderNumber.objects.get(id=pk)
        order = Order.objects.filter(order=order_id).order_by('id')
        context = {
            'order_id': order_id,
            'active_home': 'active',
            'order': order,
            'order_comment': OrderComment.objects.filter(order=order_id),
        }
        return render(request, self.template, context)

    @method_decorator(permission_required('auth.production_rw'))
    def post(self, request, pk):
        if 'add_order_comment' in request.POST:
            comment = OrderComment()
            comment.comment = request.POST['comment']
            comment.order = OrderNumber.objects.get(id=pk)
            comment.user = auth.get_user(request)
            comment.save()
        return HttpResponseRedirect(request.path)


class ProductionPositionDesign(View):
    template = "production/design_order.html"
    design_formset = modelformset_factory(DesignImage, fields=('id', 'image', 'confirm', 'position'), extra=1, 
        widgets={
                'id': forms.TextInput(attrs={'type': 'hidden'}),
                    })

    @method_decorator(permission_required('auth.production_rw'))
    def get(self, request, order_pk, position_pk):
        order_id = OrderNumber.objects.get(id=order_pk)
        order = Order.objects.filter(order=order_id).order_by('id')
        formset = self.design_formset(queryset=DesignImage.objects.filter(position=Order.objects.get(id=position_pk)))
        comments = DesignImageComment.objects.filter(position=Order.objects.get(id=position_pk))
        docs = DesignFilesForProduction.objects.filter(position=position_pk)
        position = Order.objects.get(id=position_pk)
        try:
            design1 = Design1Form(instance=Design1.objects.get(position=Order.objects.get(id=position_pk)))
        except:
            design1 = Design1Form()
        try:
            design2 = Design2Form(instance=Design2.objects.get(position=Order.objects.get(id=position_pk)))
        except:
            design2 = Design2Form()
        try:
            design3 = Design3Form(instance=Design3.objects.get(position=Order.objects.get(id=position_pk)))
        except:
            design3 = Design3Form()
        try:
            design4 = Design4Form(instance=Design4.objects.get(position=Order.objects.get(id=position_pk)))
        except:
            design4 = Design4Form()
        upload_design = UploadDesign()
        try: 
            img1 = Design1.objects.get(position=Order.objects.get(id=position_pk))
        except:
            img1 = ""
        try: 
            img2 = Design2.objects.get(position=Order.objects.get(id=position_pk))
        except:
            img2 = ""
        try: 
            img3 = Design3.objects.get(position=Order.objects.get(id=position_pk))
        except:
            img3 = ""
        try: 
            img4 = Design4.objects.get(position=Order.objects.get(id=position_pk))
        except:
            img4 = ""
        context = {
            'position': position,
            'docs': docs,
            'order_id': order_id,
            'active_home': 'active',
            'order': order,
            'upload_design': upload_design,
            'design': formset,
            'comments': comments,
            'design1': design1,
            'design2': design2,
            'design3': design3,
            'design4': design4,
            'design_img1': img1,
            'design_img2': img2,
            'design_img3': img3,
            'design_img4': img4,
            'order_comment': OrderComment.objects.filter(order=order_id),
        }
        return render(request, self.template, context)

    @method_decorator(permission_required('auth.production_rw'))
    def post(self, request, order_pk, position_pk):
        if 'add_comment' in request.POST:
            comment = DesignImageComment()
            comment.comment = request.POST['comment']
            comment.user = auth.get_user(request)
            comment.position = Order.objects.get(id=position_pk)
            comment.save()
        if 'add_order_comment' in request.POST:
            comment = OrderComment()
            comment.comment = request.POST['comment']
            comment.order = OrderNumber.objects.get(id=order_pk)
            comment.user = auth.get_user(request)
            comment.save()
        return HttpResponseRedirect(request.path)


class Production_specifications(View):
    template = 'production/specifications.html'

    @method_decorator(permission_required('auth.production_rw'))
    def get(self, request):
        specifications = DesignSpecification.objects.all()
        context = {
            'active_specifications': 'active',
            'specifications': specifications,
        }
        return render(request, self.template, context)


class Production_specifications_add(View):
    template = "production/add_specifications.html"

    @method_decorator(permission_required('auth.production_rw'))
    def get(self, request):
        add_specifications = DesignSpecificationForm()
        context = {
            'specification': add_specifications,
            'active_specifications': 'active',
        }
        return render(request, self.template, context)

    @method_decorator(permission_required('auth.production_rw'))
    def post(elf, request):
        add_specifications = DesignSpecificationForm(request.POST, request.FILES)
        if add_specifications.is_valid():
            add_specifications.save()
        return HttpResponseRedirect('/production/specifications')


class Production_specifications_remove(View):

    @method_decorator(permission_required('auth.production_rw'))
    def get(self, request, pk):
        DesignSpecification.objects.get(id=pk).delete()
        return HttpResponseRedirect('/production/specifications')


class ProductionSecification_info(View):
    template = 'production/specification.html'

    @method_decorator(permission_required('auth.production_rw'))
    def get(self, request, pk):
        specification = DesignSpecification.objects.get(id=pk)
        context = {
            'specification': specification,
            'active_specifications': 'active',    
        }
        return render(request, self.template, context)

class Designer(View):

    template = 'designer/designer.html'

    @method_decorator(permission_required('auth.designer_rw'))
    def get(self, request):
        return render(request, self.template)

    @method_decorator(permission_required('auth.designer_rw'))
    def post(self, request):
        pass


class Designer_specifications(View):
    template = 'designer/specifications.html'

    @method_decorator(permission_required('auth.designer_rw'))
    def get(self, request):
        specifications = DesignSpecification.objects.all()
        context = {
            'active_specifications': 'active',
            'specifications': specifications,
        }
        return render(request, self.template, context)


class DocDelete(View):
    def get(self, request, pk):
        OrderDocuments.objects.get(id=pk).delete()
        return HttpResponseRedirect('/')


class Designer_specifications_add(View):
    template = "designer/add_specifications.html"

    @method_decorator(permission_required('auth.designer_rw'))
    def get(self, request):
        add_specifications = DesignSpecificationForm()
        context = {
            'specification': add_specifications,
            'active_specifications': 'active',
        }
        return render(request, self.template, context)

    @method_decorator(permission_required('auth.designer_rw'))
    def post(elf, request):
        add_specifications = DesignSpecificationForm(request.POST, request.FILES)
        if add_specifications.is_valid():
            add_specifications.save()
        return HttpResponseRedirect('/designer/specifications')


class Designer_specifications_remove(View):

    @method_decorator(permission_required('auth.designer_rw'))
    def get(self, request, pk):
        DesignSpecification.objects.get(id=pk).delete()
        return HttpResponseRedirect('/designer/specifications')

class DesignerSecification_info(View):
    template = 'designer/specification.html'

    @method_decorator(permission_required('auth.designer_rw'))
    def get(self, request, pk):
        specification = DesignSpecification.objects.get(id=pk)
        context = {
            'specification': specification,
            'active_specifications': 'active',    
        }
        return render(request, self.template, context)


class Designer_orders(View):

    template = 'designer/orders.html'

    @method_decorator(permission_required('auth.designer_rw'))
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


class Designer_orders_edit(View):

    template = 'designer/edit_order.html'
    order_formset = modelformset_factory(Order, fields=('id', 'designer_date', 'design_specification'), 
        widgets={
                    'designer_date': forms.DateInput(format=('%Y-%m-%d'), attrs={'class': 'form-control input-sm', 'type': 'date'},),
                    'design_specification': forms.Select(attrs={'class': 'form-control input-sm'}),
                })

    @method_decorator(permission_required('auth.designer_rw'))
    def get(self, request, pk):
        order_id = OrderNumber.objects.get(id=pk)
        order = Order.objects.filter(order=order_id).order_by('id')
        formset = self.order_formset(queryset=Order.objects.filter(order=order_id).order_by('id'))
        order_edit = AddDocForm()
        docs = FilesForProduction.objects.filter(order=order_id)
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
            new_formset['design_specification']=i.design_specification_new
            new_formset['production_status']=i.production_status
            new_formset['summary']=i.summary
            new_formset['provider']=i.provider
            new_formset['design_requirements_new']=i.design_requirements_new
            new_formset['post_payment']=i.post_payment
            new_formset['pre_payment']=i.pre_payment
            new_formset['production_status']=i.production_status
            new_formset['designer']=formset[l]
            new_order.append(new_formset)
            l = l + 1
        context = {
            'order_id': order_id,
            'active_home': 'active',
            'order_edit': order_edit,
            'docs': docs,
            'order': new_order,
            'order_comment': OrderComment.objects.filter(order=order_id),
            'designer_motivation': OrderNumber.objects.calculate_designer_motivation(pk),
            'formset': formset, 
        }
        return render(request, self.template, context)

    @method_decorator(permission_required('auth.designer_rw'))
    def post(self, request, pk):
        if 'add_order_comment' in request.POST:
            comment = OrderComment()
            comment.comment = request.POST['comment']
            comment.order = OrderNumber.objects.get(id=pk)
            comment.user = auth.get_user(request)
            comment.save()
        if 'send_date' in request.POST:
            formset = self.order_formset(request.POST)
            if formset.is_valid():
                formset.save()
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


class Designer_position_design(View):
    template = 'designer/edit_order.html'

    design_formset = modelformset_factory(DesignImage, fields=('id', 'image', 'confirm', 'position'), extra=1, 
        widgets={
                'id': forms.TextInput(attrs={'type': 'hidden'}),
                    })

    @method_decorator(permission_required('auth.designer_rw'))
    def get(self, request, order_pk, position_pk):
        order_id = OrderNumber.objects.get(id=order_pk)
        order = Order.objects.filter(order=order_id).order_by('id')
        formset = self.design_formset(queryset=DesignImage.objects.filter(position=Order.objects.get(id=position_pk)))
        comments = DesignImageComment.objects.filter(position=Order.objects.get(id=position_pk))
        order_edit = AddDocForm()
        position = Order.objects.get(id=position_pk)
        docs = FilesForProduction.objects.filter(order=order_id)
        files = DesignFilesForProduction.objects.filter(position=position_pk)
        try:
            design1 = Design1Form(instance=Design1.objects.get(position=Order.objects.get(id=position_pk)))
        except:
            design1 = Design1Form()
        try:
            design2 = Design2Form(instance=Design2.objects.get(position=Order.objects.get(id=position_pk)))
        except:
            design2 = Design2Form()
        try:
            design3 = Design3Form(instance=Design3.objects.get(position=Order.objects.get(id=position_pk)))
        except:
            design3 = Design3Form()
        try:
            design4 = Design4Form(instance=Design4.objects.get(position=Order.objects.get(id=position_pk)))
        except:
            design4 = Design4Form()
        upload_design = UploadDesign()
        try: 
            img1 = Design1.objects.get(position=Order.objects.get(id=position_pk))
        except:
            img1 = ""
        try: 
            img2 = Design2.objects.get(position=Order.objects.get(id=position_pk))
        except:
            img2 = ""
        try: 
            img3 = Design3.objects.get(position=Order.objects.get(id=position_pk))
        except:
            img3 = ""
        try: 
            img4 = Design4.objects.get(position=Order.objects.get(id=position_pk))
        except:
            img4 = ""
        context = {
            'position': position,
            'files': files,
            'order_id': order_id,
            'order_edit': order_edit,
            'docs': docs,
            'active_home': 'active',
            'order': order,
            'upload_design': upload_design,
            'design': formset,
            'comments': comments,
            'design1': design1,
            'design2': design2,
            'design3': design3,
            'design4': design4,
            'design_img1': img1,
            'design_img2': img2,
            'design_img3': img3,
            'design_img4': img4,
            'order_comment': OrderComment.objects.filter(order=order_id),
            'designer_motivation': OrderNumber.objects.calculate_designer_motivation(order_pk)
        }
        return render(request, self.template, context)

    @method_decorator(permission_required('auth.designer_rw'))
    def post(self, request, order_pk, position_pk):
        if 'file_id' in request.POST:
            DesignFilesForProduction.objects.get(id=request.POST['file_id']).delete()
        if 'change_image' in request.POST:
            formset = self.design_formset(request.POST, request.FILES)
            if formset.is_valid():
                f_change = formset.save(commit=False)
                for i in f_change:
                    i.position = Order.objects.get(id=position_pk)
                    i.save()
                formset.save()
        if 'add_comment' in request.POST:
            comment = DesignImageComment()
            comment.comment = request.POST['comment']
            comment.user = auth.get_user(request)
            comment.position = Order.objects.get(id=position_pk)
            comment.save()
        if 'add_order_comment' in request.POST:
            comment = OrderComment()
            comment.comment = request.POST['comment']
            comment.order = OrderNumber.objects.get(id=order_pk)
            comment.user = auth.get_user(request)
            comment.save()
        if 'add_design1' in request.POST:
            try:
                design1 = Design1Form(request.POST, request.FILES, instance=Design1.objects.get(position=Order.objects.get(id=position_pk)))
            except: 
                design1 = Design1Form(request.POST, request.FILES)
            if design1.is_valid():
                d = design1.save(commit=False)
                d.position = Order.objects.get(id=position_pk)
                d.save()
        if 'add_design2' in request.POST:
            try:
                design2 = Design2Form(request.POST, request.FILES, instance=Design2.objects.get(position=Order.objects.get(id=position_pk)))
            except: 
                design2 = Design2Form(request.POST, request.FILES)
            if design2.is_valid():
                d = design2.save(commit=False)
                d.position = Order.objects.get(id=position_pk)
                d.save()
        if 'add_design3' in request.POST:
            try:
                design3 = Design3Form(request.POST, request.FILES, instance=Design3.objects.get(position=Order.objects.get(id=position_pk)))
            except: 
                design3 = Design3Form(request.POST, request.FILES)
            if design3.is_valid():
                d = design3.save(commit=False)
                d.position = Order.objects.get(id=position_pk)
                d.save()
        if 'add_design4' in request.POST:
            try:
                design4 = Design4Form(request.POST, request.FILES, instance=Design4.objects.get(position=Order.objects.get(id=position_pk)))
            except: 
                design4 = Design4Form(request.POST, request.FILES)
            if design4.is_valid():
                d = design4.save(commit=False)
                d.position = Order.objects.get(id=position_pk)
                d.save()
        if 'img1_to_chat' in request.POST:
            comment = DesignImageComment()
            design = Design1.objects.get(position=Order.objects.get(id=position_pk))
            comment.design = design.picture
            comment.user = auth.get_user(request)
            comment.position = Order.objects.get(id=position_pk)
            comment.save()
        if 'img2_to_chat' in request.POST:
            comment = DesignImageComment()
            design = Design2.objects.get(position=Order.objects.get(id=position_pk))
            comment.design = design.picture
            comment.user = auth.get_user(request)
            comment.position = Order.objects.get(id=position_pk)
            comment.save()
        if 'img3_to_chat' in request.POST:
            comment = DesignImageComment()
            design = Design3.objects.get(position=Order.objects.get(id=position_pk))
            comment.design = design.picture
            comment.user = auth.get_user(request)
            comment.position = Order.objects.get(id=position_pk)
            comment.save()
        if 'img4_to_chat' in request.POST:
            comment = DesignImageComment()
            design = Design4.objects.get(position=Order.objects.get(id=position_pk))
            comment.design = design.picture
            comment.user = auth.get_user(request)
            comment.position = Order.objects.get(id=position_pk)
            comment.save()
        if 'docs' in request.POST:
            docs = AddDocForm(request.POST, request.FILES)
            if docs.is_valid():
                doc = OrderDocuments()
                doc.title = docs.cleaned_data['title']
                doc.discription = docs.cleaned_data['discription']
                doc.file = docs.cleaned_data['file']
                doc.order = OrderNumber.objects.get(id=order_pk)
                doc.save()
        return HttpResponseRedirect(request.path)


class Delete_position_design(View):

    @method_decorator(permission_required('auth.designer_rw'))
    def get(self, request, order_pk, position_pk, design_pk):
        try:
            DesignImage.objects.get(id=design_pk).delete()
        except:
            pass
        return HttpResponseRedirect('/designer/order/{0}/position/{1}'.format(order_pk, position_pk))


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

    @method_decorator(permission_required('auth.logist_rw'))
    def get(self, request, pk):
        order_id = OrderNumber.objects.get(id=pk)
        order = Order.objects.filter(order=order_id).order_by('id')
        order_edit = AddDocForm()
        docs = OrderDocuments.objects.filter(order=order_id)
        comments = OrderComment.objects.filter(order=order_id)
        logist_price = LogistPriceForm(instance=order_id)
        context = {
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
        }
        return render(request, self.template, context)

    @method_decorator(permission_required('auth.logist_rw'))
    def post(self, request, pk):
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
        order = Order.objects.filter(order=order_id)
        context = {
             'active_home': 'active',
             'order': order,
             'order_id': order_id,
             'summary': OrderNumber.objects.summary(pk),
        }
        return render(request, self.template, context)

    @method_decorator(permission_required('auth.client_rw'))
    def post(self, request, pk):
        pass


class ClientPositionDesign(View):
    template = "client/order.html"

    design_formset = modelformset_factory(DesignImage, fields=('id', 'image', 'confirm', 'position'), extra=1, 
        widgets={
                'id': forms.TextInput(attrs={'type': 'hidden'}),
                    })

    @method_decorator(permission_required('auth.client_rw'))
    def get(self, request, order_pk, position_pk):
        order_id = OrderNumber.objects.get(id=order_pk)
        order = Order.objects.filter(order=order_id).order_by('id')
        formset = self.design_formset(queryset=DesignImage.objects.filter(position=Order.objects.get(id=position_pk)))
        comments = DesignImageComment.objects.filter(position=Order.objects.get(id=position_pk))
        in_production = Order.objects.get(id=position_pk)
        try:
            design1 = Design1Form(instance=Design1.objects.get(position=Order.objects.get(id=position_pk)))
        except:
            design1 = Design1Form()
        try:
            design2 = Design2Form(instance=Design2.objects.get(position=Order.objects.get(id=position_pk)))
        except:
            design2 = Design2Form()
        try:
            design3 = Design3Form(instance=Design3.objects.get(position=Order.objects.get(id=position_pk)))
        except:
            design3 = Design3Form()
        try:
            design4 = Design4Form(instance=Design4.objects.get(position=Order.objects.get(id=position_pk)))
        except:
            design4 = Design4Form()
        upload_design = UploadDesign()
        try: 
            img1 = Design1.objects.get(position=Order.objects.get(id=position_pk))
        except:
            img1 = ""
        try: 
            img2 = Design2.objects.get(position=Order.objects.get(id=position_pk))
        except:
            img2 = ""
        try: 
            img3 = Design3.objects.get(position=Order.objects.get(id=position_pk))
        except:
            img3 = ""
        try: 
            img4 = Design4.objects.get(position=Order.objects.get(id=position_pk))
        except:
            img4 = ""
        context = {
            'status': str(in_production.production_status),
            'order_id': order_id,
            'active_home': 'active',
            'order': order,
            'upload_design': upload_design,
            'design': formset,
            'comments': comments,
            'design1': design1,
            'design2': design2,
            'design3': design3,
            'design4': design4,
            'design_img1': img1,
            'design_img2': img2,
            'design_img3': img3,
            'design_img4': img4,
            'order_comment': OrderComment.objects.filter(order=order_id),
            'summary': OrderNumber.objects.summary(order_pk),
            'pre_payment': OrderNumber.objects.pre_payment(order_pk),
            'post_payment': OrderNumber.objects.post_payment(order_pk),
        }
        return render(request, self.template, context)


    @method_decorator(permission_required('auth.client_rw'))
    def post(self, request, order_pk, position_pk):
        if 'add_comment' in request.POST:
            comment = DesignImageComment()
            comment.comment = request.POST['comment']
            comment.user = auth.get_user(request)
            comment.position = Order.objects.get(id=position_pk)
            comment.save()
        if 'img1_to_chat' in request.POST:
            comment = DesignImageComment()
            design = Design1.objects.get(position=Order.objects.get(id=position_pk))
            comment.design = design.picture
            comment.user = auth.get_user(request)
            comment.position = Order.objects.get(id=position_pk)
            comment.save()
        if 'img2_to_chat' in request.POST:
            comment = DesignImageComment()
            design = Design2.objects.get(position=Order.objects.get(id=position_pk))
            comment.design = design.picture
            comment.user = auth.get_user(request)
            comment.position = Order.objects.get(id=position_pk)
            comment.save()
        if 'img3_to_chat' in request.POST:
            comment = DesignImageComment()
            design = Design3.objects.get(position=Order.objects.get(id=position_pk))
            comment.design = design.picture
            comment.user = auth.get_user(request)
            comment.position = Order.objects.get(id=position_pk)
            comment.save()
        if 'img4_to_chat' in request.POST:
            comment = DesignImageComment()
            design = Design4.objects.get(position=Order.objects.get(id=position_pk))
            comment.design = design.picture
            comment.user = auth.get_user(request)
            comment.position = Order.objects.get(id=position_pk)
            comment.save()
        if 'confirm_1' in request.POST:
            design = Design1.objects.get(position=Order.objects.get(id=position_pk))
            design.confirm = True
            design.save()
        if 'confirm_2' in request.POST:
            design = Design2.objects.get(position=Order.objects.get(id=position_pk))
            design.confirm = True
            design.save()
        if 'confirm_3' in request.POST:
            design = Design3.objects.get(position=Order.objects.get(id=position_pk))
            design.confirm = True
            design.save()
        if 'confirm_4' in request.POST:
            design = Design4.objects.get(position=Order.objects.get(id=position_pk))
            design.confirm = True
            design.save()
        return HttpResponseRedirect(request.path)


class DesignerFilesForProduction(View):
    template = "designer/files.html"

    @method_decorator(permission_required('auth.designer_rw'))
    def get(self, request, pk, position_pk):
        file_form = DesignFilesForProductionForm()
        context = {
            'file_form': file_form
        }
        return render(request, self.template, context)

    @method_decorator(permission_required('auth.designer_rw'))
    def post(self, request, pk, position_pk):
        file_form = DesignFilesForProductionForm(request.POST, request.FILES)
        if file_form.is_valid():
            file = file_form.save(commit=False)
            file.position = Order.objects.get(id=position_pk)
            file.save()
        return HttpResponseRedirect('/designer/orders/edit/{0}'.format(pk))


class DesignerItems(View):
    template = 'designer/items.html'

    def get(self, request):
        items = Item.objects.all()
        context = {
            'items': items,
            'active_items': 'active',
        }
        return render(request, self.template, context)


class DesignerClients(View):
    template = 'designer/clients.html'

    @method_decorator(permission_required('auth.designer_rw'))
    def get(self, request,):
        clients_list = ClientProfile.objects.filter(client_type=2)
        context = {
            'clients_list': clients_list,
            'active_clients': 'active',
        }
        return  render(request, self.template, context)


class DesignerClientData(View):
    template = 'designer/client_data.html'

    @method_decorator(permission_required('auth.designer_rw'))
    def get(self, request, pk):
        client_docs_form = ClientDocumentsForm()
        client_brand_form = ClientBrandbookForm()
        client_profile = ClientProfile.objects.get(id=pk)
        client_docs = ClientDocuments.objects.filter(client=client_profile)
        brandbook_docs = ClientBrandbook.objects.filter(client=client_profile)
        contract_attached_form = ContactAttachedForm(instance=client_profile)
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

    @method_decorator(permission_required('auth.designer_rw'))
    def post(self, request, pk):
        if request.POST.get('add_file', 'no') == 'yes':
            client_docs_form = ClientDocumentsForm(request.POST, request.FILES)
            if client_docs_form.is_valid():
                docs = client_docs_form.save(commit=False)
                docs.client = ClientProfile.objects.get(id=pk)
                docs.save()
                return HttpResponseRedirect('/designer/client/{0}'.format(pk))
        if request.POST.get('add_brand', 'no') == 'yes':
            client_brand_form = ClientBrandbookForm(request.POST, request.FILES)
            if client_brand_form.is_valid():
                docs = client_brand_form.save(commit=False)
                docs.client = ClientProfile.objects.get(id=pk)
                docs.save()
                return HttpResponseRedirect('/designer/client/{0}'.format(pk))


class DeleteClientFile(View):
    def get(self, request, pk):
        ClientDocuments.objects.get(id=pk).delete()
        return HttpResponseRedirect(request.GET.get('next'))


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


# Доп работы Январь 2019

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


class RemoveBrandbook(View):

    def get(self, request, pk):
        ClientBrandbook.objects.get(id=pk).delete()
        return HttpResponseRedirect(request.GET.get('next'))


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


class ChangeClientProfileManager(View):
    template = 'manager/change_client_profile.html'


    @method_decorator(permission_required('auth.manage_clients'))
    def get(self, request, pk):
        client_profile = ClientProfile.objects.get(id=pk)
        client_profile_form = ClientProfileManagerForm(instance=client_profile)
        context = {
            'active_clients': 'active',
            'client_profile': client_profile,
            'client_profile_form': client_profile_form,
        }
        return render(request, self.template, context)


    @method_decorator(permission_required('auth.manage_clients'))
    def post(self, request, pk):
        client_profile = ClientProfile.objects.get(id=pk)
        client_profile_form = ClientProfileManagerForm(request.POST, instance=client_profile)
        if client_profile_form.is_valid():
            # replace_text = client_profile_form.cleaned_data['requisites'].replace('\n\r', '<br> ')
            # replace_text = client_profile_form.cleaned_data['requisites'].replace('\n', '<br> ')
            # client_profile_form.requisites = replace_text
            client_profile_form.save()
        return HttpResponseRedirect('/manager/client_profile/{0}'.format(pk))


class DesignerTechReqsList(View):
    template = 'designer/t_reqs.html'

    @method_decorator(permission_required('auth.designer_rw'))
    def get(self, request):
        t_reqs = DesignerTReq.objects.all()
        context = {
            't_reqs': t_reqs,
            'active_t_reqs': 'active',
        }
        return render(request, self.template, context)


class DesignerTechReqAdd(View):
    template = 'designer/create_t_req.html'

    @method_decorator(permission_required('auth.designer_rw'))
    def get(self, request):
        create_t_req_form = DesignerTReqForm()
        context = {
            'active_t_reqs': 'active',
            'create_t_req_form': create_t_req_form,
        }
        return render(request, self.template, context)

    @method_decorator(permission_required('auth.designer_rw'))
    def post(self, request):
        create_t_req_form = DesignerTReqForm(request.POST)
        if create_t_req_form.is_valid():
            create_t_req_form.save()
        return HttpResponseRedirect('/designer/technical_requirements')


class DesignerShowTReq(View):
    template = 'designer/show_t_req.html'

    def get(self, request, pk):
        t_req = DesignerTReq.objects.get(id=pk)
        context = {
            'active_t_reqs': 'active',
            't_req': t_req,
        }
        return render(request, self.template, context)


class DesignerEditTReq(View):
    template = 'designer/create_t_req.html'

    def get(self, request, pk):
        t_req = DesignerTReq.objects.get(id=pk)
        create_t_req_form = DesignerTReqForm(instance=t_req)
        context = {
            'active_t_reqs': 'active',
            'create_t_req_form': create_t_req_form,
        }
        return render(request, self.template, context)

    def post(self, request, pk):
        t_req = DesignerTReq.objects.get(id=pk)
        create_t_req_form = DesignerTReqForm(request.POST, instance=t_req)
        if create_t_req_form.is_valid():
            create_t_req_form.save()
        return HttpResponseRedirect('/designer/technical_requirements')


class DeleteTReq(View):

    def get(self, request, pk):
        DesignerTReq.objects.get(id=pk).delete()
        return HttpResponseRedirect(request.GET.get('next'))


class ProductionTechReqsList(View):
    template = "production/t_reqs.html"

    def get(self, request):
        t_reqs = DesignerTReq.objects.all()
        context = {
            't_reqs': t_reqs,
            'active_t_reqs': 'active',
        }
        return render(request, self.template, context)


class ProductionTechReqAdd(View):
    template = 'production/create_t_req.html'

    def get(self, request):
        create_t_req_form = DesignerTReqForm()
        context = {
            'active_t_reqs': 'active',
            'create_t_req_form': create_t_req_form,
        }
        return render(request, self.template, context)

    def post(self, request):
        create_t_req_form = DesignerTReqForm(request.POST)
        if create_t_req_form.is_valid():
            create_t_req_form.save()
        return HttpResponseRedirect('/production/technical_requirements')


class ProductionShowTReq(View):
    template = 'production/show_t_req.html'

    def get(self, request, pk):
        t_req = DesignerTReq.objects.get(id=pk)
        context = {
            'active_t_reqs': 'active',
            't_req': t_req,
        }
        return render(request, self.template, context)


class ProductionEditTReq(View):
    template = 'production/create_t_req.html'

    def get(self, request, pk):
        t_req = DesignerTReq.objects.get(id=pk)
        create_t_req_form = DesignerTReqForm(instance=t_req)
        context = {
            'active_t_reqs': 'active',
            'create_t_req_form': create_t_req_form,
        }
        return render(request, self.template, context)

    def post(self, request, pk):
        t_req = DesignerTReq.objects.get(id=pk)
        create_t_req_form = DesignerTReqForm(request.POST, instance=t_req)
        if create_t_req_form.is_valid():
            create_t_req_form.save()
        return HttpResponseRedirect('/designer/technical_requirements')


class ProductionTechTasksList(View):
    template = "production/t_tasks.html"

    def get(self, request):
        t_tasks = ProductionTTask.objects.all()
        context = {
            't_tasks': t_tasks,
            'active_t_tasks': 'active',
        }
        return render(request, self.template, context)


class ProductionTechTasksAdd(View):
    template = "production/create_t_task.html"

    def get(self, request):
        create_t_task_form = DesignerTTaskForm()
        context = {
            'create_t_task_form': create_t_task_form,
            'active_t_tasks': 'active',
        }
        return render(request, self.template, context)

    def post(self, request):
        create_t_task_form = DesignerTTaskForm(request.POST)
        if create_t_task_form.is_valid():
            create_t_task_form.save()
        return HttpResponseRedirect('/production/technical_tasks')


class ProductionShowTTasks(View):
    template = "production/show_t_task.html"

    def get(self, request, pk):
        t_task = ProductionTTask.objects.get(id=pk)
        context = {
            't_task': t_task,
            'active_t_tasks': 'active',
        }
        return render(request, self.template, context)



class ProductionEditTTasks(View):
    template = "production/create_t_task.html"

    def get(self, request, pk):
        t_task = ProductionTTask.objects.get(id=pk)
        create_t_task_form = DesignerTTaskForm(instance=t_task)
        context = {
            'active_t_tasks': 'active',
            'create_t_task_form': create_t_task_form,
        }
        return render(request, self.template, context)

    def post(self, request, pk):
        t_task = ProductionTTask.objects.get(id=pk)
        create_t_task_form = DesignerTTaskForm(request.POST, instance=t_task)
        if create_t_task_form.is_valid():
            create_t_task_form.save()
        return HttpResponseRedirect('/production/technical_tasks')


class ProductionDeleteTTasks(View):

    def get(self, request, pk):
        ProductionTTask.objects.get(id=pk).delete()
        return HttpResponseRedirect('/production/technical_tasks')


class Design(View):
    template = 'designer/design.html'

    def get(self, request, order_id, position_id):
        position = Order.objects.get(id=position_id)
        try:
            design1 = Design1Form(instance=Design1.objects.get(position=Order.objects.get(id=position_id)))
        except:
            design1 = Design1Form()
        try:
            design2 = Design2Form(instance=Design2.objects.get(position=Order.objects.get(id=position_id)))
        except:
            design2 = Design2Form()
        try:
            design3 = Design3Form(instance=Design3.objects.get(position=Order.objects.get(id=position_id)))
        except:
            design3 = Design3Form()
        try:
            design4 = Design4Form(instance=Design4.objects.get(position=Order.objects.get(id=position_id)))
        except:
            design4 = Design4Form()
        upload_design = UploadDesign()
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
            'design1': design1,
            'design2': design2,
            'design3': design3,
            'design4': design4,
            'design_img1': img1,
            'design_img2': img2,
            'design_img3': img3,
            'design_img4': img4,
            'active_home': 'active',
            'position': position
        }
        return render(request, self.template, context)


    def post(self, request, order_id, position_id):
        if 'add_design1' in request.POST:
            try:
                design1 = Design1Form(request.POST, request.FILES, instance=Design1.objects.get(position=Order.objects.get(id=position_id)))
            except: 
                design1 = Design1Form(request.POST, request.FILES)
            if design1.is_valid():
                d = design1.save(commit=False)
                d.position = Order.objects.get(id=position_id)
                d.save()
        if 'add_design2' in request.POST:
            try:
                design2 = Design2Form(request.POST, request.FILES, instance=Design2.objects.get(position=Order.objects.get(id=position_id)))
            except: 
                design2 = Design2Form(request.POST, request.FILES)
            if design2.is_valid():
                d = design2.save(commit=False)
                d.position = Order.objects.get(id=position_id)
                d.save()
        if 'add_design3' in request.POST:
            try:
                design3 = Design3Form(request.POST, request.FILES, instance=Design3.objects.get(position=Order.objects.get(id=position_id)))
            except: 
                design3 = Design3Form(request.POST, request.FILES)
            if design3.is_valid():
                d = design3.save(commit=False)
                d.position = Order.objects.get(id=position_id)
                d.save()
        if 'add_design4' in request.POST:
            try:
                design4 = Design4Form(request.POST, request.FILES, instance=Design4.objects.get(position=Order.objects.get(id=position_id)))
            except: 
                design4 = Design4Form(request.POST, request.FILES)
            if design4.is_valid():
                d = design4.save(commit=False)
                d.position = Order.objects.get(id=position_id)
                d.save()
        return HttpResponseRedirect(request.path)


class ProductionPositionDesign(View):
    template = 'production/design.html'

    def get(self, request, order_id, position_id):
        position = Order.objects.get(id=position_id)
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
            'design_img1': img1,
            'design_img2': img2,
            'design_img3': img3,
            'design_img4': img4,
            'active_home': 'active',
            'position': position
        }
        return render(request, self.template, context)


class ManagerPositionDesign(View):
    template = 'manager/design.html'

    def get(self, request, order_id, position_id):
        position = Order.objects.get(id=position_id)
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
            'design_img1': img1,
            'design_img2': img2,
            'design_img3': img3,
            'design_img4': img4,
            'active_orders': 'active',
            'position': position
        }
        return render(request, self.template, context)


class ChangeClientProfileDesigner(View):
    template = 'designer/change_client_profile.html'

    def get(self, request, pk):
        client_profile = ClientProfile.objects.get(id=pk)
        client_profile_form = ClientProfileManagerForm(instance=client_profile)
        context = {
            'active_clients': 'active',
            'client_profile': client_profile,
            'client_profile_form': client_profile_form,
        }
        return render(request, self.template, context)

    def post(self, request, pk):
        client_profile = ClientProfile.objects.get(id=pk)
        client_profile_form = ClientProfileManagerForm(request.POST, instance=client_profile)
        if client_profile_form.is_valid():
            client_profile_form.save()
        return HttpResponseRedirect('/designer/client/{0}'.format(pk))
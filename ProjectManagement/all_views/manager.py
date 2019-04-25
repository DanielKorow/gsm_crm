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
        

# Удаление позиции из корзины
class Position_remove(View):

    @method_decorator(permission_required('auth.manage_clients'))
    def get(self, request, client, pk):
        cart = Cart_(request)
        cart.remove_position(pk)
        return HttpResponseRedirect('/manager/orders/add/{0}'.format(client))

# Удаление позици из заказа
class OrderPosition_remove(View):

    @method_decorator(permission_required('auth.manage_clients'))
    def get(self, request, order_number,  pk):
        Order.objects.get(id=pk).delete()
        return HttpResponseRedirect('/manager/orders/edit/{0}'.format(order_number))


class Orders_edit(View):

    template = 'manager/edit_order.html'

    # Менеджер ознакамливается с изменениями
    def mark_client(self, id):
        order_id = OrderNumber.objects.get(id=id)
        order_id.mark_client_for_manager = False
        order_id.save()

    @method_decorator(permission_required('auth.manage_clients'))
    def get(self, request, pk):
        self.mark_client(id=pk)
        order_id = OrderNumber.objects.get(id=pk)
        order = Order.objects.filter(order=order_id)
        order_edit = AddDocForm()
        add_item_form = AddOrdersForm()
        docs = OrderDocuments.objects.filter(order=order_id)
        comments = OrderComment.objects.filter(order=order_id)
        adding_cost = ManagerAddingCostForm(instance=order_id)
        addagr = AddAgrForm(instance=order_id)
        context = {
            'add_item': add_item_form,
            'file_upload_form': FilesForChatForm(),               # Файлы для чата
            'files': FilesForChat.objects.filter(order=order_id), # Файлы для чата
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
            'order_chat': NewChatOrder.objects.filter(order=order_id),
        }
        return render(request, self.template, context)


    # Менеджер помечает что есть изменения
    def mark_manager(self, id):
        order_id = OrderNumber.objects.get(id=id)
        order_id.mark_manager = True
        order_id.save()

    @method_decorator(permission_required('auth.manage_clients'))
    def post(self, request, pk):
        self.mark_manager(id=pk)
        if 'file_for_chat' in request.POST:
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
        if 'add_position' in request.POST:
            add_item_form = AddOrdersForm(request.POST)
            order = OrderNumber.objects.get(id=pk)
            f = open('forms_errors', 'w')
            f.write(str(add_item_form.errors.as_data()))
            f.close()
            if add_item_form.is_valid():
                position = Order()
                position.item = add_item_form.cleaned_data['item']
                position.app_method = add_item_form.cleaned_data['app_method']
                position.material = add_item_form.cleaned_data['material']
                position.quantity = add_item_form.cleaned_data['quantity']
                position.pre_payment = add_item_form.cleaned_data['pre_payment']
                position.price = add_item_form.cleaned_data['price']
                position.info = add_item_form.cleaned_data['info']
                position.order = order
                position.save()
        return HttpResponseRedirect(request.path)


class Change_order(View):

    template = 'manager/change_order.html'
    order_formset = modelformset_factory(Order, fields=('id', 'item', 'price', 'pre_payment', 'quantity' , 'info', 'production_purchase_price', 'app_method', 
        'material'), 
        widgets={
                    'id': forms.TextInput(attrs={'type': 'hidden'}),
                    'price': forms.NumberInput(attrs={'class': 'form-control'}), 
                    'pre_payment': forms.NumberInput(attrs={'class': 'form-control', 'required': ''}), 
                    'quantity': forms.NumberInput(attrs={'class': 'form-control'}),
                    'info': forms.TextInput(attrs={'class': 'form-control'}),
                    'production_purchase_price': forms.NumberInput(attrs={'class': 'form-control'}),
                    'app_method': forms.Select(attrs={'class': 'form-control input-sm'}),
                    'material': forms.Select(attrs={'class': 'form-control input-sm'}),
                    'item': forms.Select(attrs={'class': 'form-control input-sm'}),
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
            # new_formset['item']=i.item
            # new_formset['size']=i.size
            # new_formset['app_method']=i.app_method
            # new_formset['material']=i.material
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
            f = open('forms_errors', 'w')
            f.write(str(formset.errors))
            f.close()
            if formset.is_valid():
                formset.save()
        return HttpResponseRedirect('/manager/orders/edit/{0}'.format(pk))


class Get_order_url(View):

    def post(self, request):
        pk=request.POST['clients']
        return HttpResponseRedirect('/manager/orders/add/{0}'.format(pk))


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
            'file_upload_form': FilesForChatForm(),               # Файлы для чата
            'files': FilesForChat.objects.filter(order=order_id), # Файлы для чата
            'design_img1': img1,
            'design_img2': img2,
            'design_img3': img3,
            'design_img4': img4,
            'active_orders': 'active',
            'position': position,
            'order_chat': NewChatOrder.objects.filter(order=order_id),
            'position_chat': NewChatPosition.objects.filter(position=position_id),
        }
        return render(request, self.template, context)

    def post(self, request, order_id, position_id):
        files_for_chat = FilesForChatForm(request.POST, request.FILES) # Файлы для чата
        if files_for_chat.is_valid():                                  # Файлы для чата
            s = files_for_chat.save(commit=False)                      # Файлы для чата
            s.order = OrderNumber.objects.get(id=order_id)             # Файлы для чата
            s.user = request.user                                      # Файлы для чата
            s.save()                                                   # Файлы для чата
        return HttpResponseRedirect(request.path)
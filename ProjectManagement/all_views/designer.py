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

    # Дизайнер ознакамливается с изменениями
    def mark_client(self, id):
        order_id = OrderNumber.objects.get(id=id)
        order_id.mark_client = False
        order_id.save()

    @method_decorator(permission_required('auth.designer_rw'))
    def get(self, request, pk):
        self.mark_client(id=pk)
        order_id = OrderNumber.objects.get(id=pk)
        order = Order.objects.filter(order=order_id).order_by('item__name')
        formset = self.order_formset(queryset=Order.objects.filter(order=order_id).order_by('item__name'))
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
            new_formset['mark_client']=i.mark_client
            new_formset['designer']=formset[l]
            new_order.append(new_formset)
            l = l + 1
        context = {
            'file_upload_form': FilesForChatForm(),               # Файлы для чата
            'files': FilesForChat.objects.filter(order=order_id), # Файлы для чата
            'order_id': order_id,
            'active_home': 'active',
            'order_edit': order_edit,
            'docs': docs,
            'order': new_order,
            'order_chat': NewChatOrder.objects.filter(order=order_id),
            'designer_motivation': OrderNumber.objects.calculate_designer_motivation(pk),
            'formset': formset, 
        }
        return render(request, self.template, context)

    # Дизайнер помечает что есть изменения
    def mark_designer(self, id):
        order_id = OrderNumber.objects.get(id=id)
        order_id.mark_designer = True
        order_id.save()

    @method_decorator(permission_required('auth.designer_rw'))
    def post(self, request, pk):
        self.mark_designer(id=pk)
        files_for_chat = FilesForChatForm(request.POST, request.FILES) # Файлы для чата
        if files_for_chat.is_valid():                                  # Файлы для чата
            s = files_for_chat.save(commit=False)                      # Файлы для чата
            s.order = OrderNumber.objects.get(id=pk)             # Файлы для чата
            s.user = request.user                                      # Файлы для чата
            s.save()                                                   # Файлы для чата
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


class Delete_position_design(View):

    @method_decorator(permission_required('auth.designer_rw'))
    def get(self, request, order_pk, position_pk, design_pk):
        try:
            DesignImage.objects.get(id=design_pk).delete()
        except:
            pass
        return HttpResponseRedirect('/designer/order/{0}/position/{1}'.format(order_pk, position_pk))


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


class Design(View):
    template = 'designer/design.html'

    def get(self, request, order_id, position_id):
        position = Order.objects.get(id=position_id)
        position.mark_client = False
        position.save()
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
            'file_upload_form': FilesForChatForm(),               # Файлы для чата
            'files': FilesForChat.objects.filter(order=order_id), # Файлы для чата
            'design1': design1,
            'design2': design2,
            'design3': design3,
            'design4': design4,
            'design_img1': img1,
            'design_img2': img2,
            'design_img3': img3,
            'design_img4': img4,
            'active_home': 'active',
            'order_chat': NewChatOrder.objects.filter(order=order_id),
            'position_chat': NewChatPosition.objects.filter(position=position_id),
            'position': position
        }
        return render(request, self.template, context)

    # Дизайнер помечает что есть изменения
    def mark_designer(self, id):
        order_id = OrderNumber.objects.get(id=id)
        order_id.mark_designer = True
        order_id.save()

    def post(self, request, order_id, position_id):
        self.mark_designer(id=order_id)
        order = Order.objects.get(id=position_id)
        order.mark_designer = True
        order.save()
        files_for_chat = FilesForChatForm(request.POST, request.FILES) # Файлы для чата
        if files_for_chat.is_valid():                                  # Файлы для чата
            s = files_for_chat.save(commit=False)                      # Файлы для чата
            s.order = OrderNumber.objects.get(id=order_id)             # Файлы для чата
            s.user = request.user                                      # Файлы для чата
            s.save()                                                   # Файлы для чата

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
        return HttpResponseRedirect(request.path)


class DesignerItems(View):
    template = 'designer/items.html'

    def get(self, request):
        items = Item.objects.all()
        context = {
            'items': items,
            'active_items': 'active',
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

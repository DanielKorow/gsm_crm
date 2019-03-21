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
            'file_upload_form': FilesForChatForm(),               # Файлы для чата
            'files': FilesForChat.objects.filter(order=order_id), # Файлы для чата
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
            'order_chat': NewChatOrder.objects.filter(order=order_id),
        }
        return render(request, self.template, context)

    @method_decorator(permission_required('auth.production_rw'))
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
            'file_upload_form': FilesForChatForm(),               # Файлы для чата
            'files': FilesForChat.objects.filter(order=order_id), # Файлы для чата
            'design_img1': img1,
            'design_img2': img2,
            'design_img3': img3,
            'design_img4': img4,
            'active_home': 'active',
            'order_chat': NewChatOrder.objects.filter(order=order_id),
            'position_chat': NewChatPosition.objects.filter(position=position_id),
            'position': position,
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
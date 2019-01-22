from django import forms
from django.forms import ModelForm
from .models import *
from django_summernote.widgets import SummernoteWidget, SummernoteInplaceWidget


class LoginForm(forms.Form):
    email = forms.EmailField(widget=forms.TextInput(attrs={'placeholder': 'Email', 'class': "form-control"}))
    password = forms.CharField(widget=forms.PasswordInput(attrs={'placeholder': 'Пароль', 'class': "form-control"}), required=False)


class ItemsForm(ModelForm):
	class Meta:
	    model = Item
	    fields = ['name', 'photo', 'info']
	    widgets = {
	    'name': forms.TextInput(attrs={'class': "form-control", }),
        'info': forms.Textarea(attrs={'class': "form-control", }),
	        }


class AppMethodForm(ModelForm):
    class Meta:
        model = ApplicationMethod
        fields = ['method']
        widgets = {
        'method': forms.TextInput(attrs={'class': "form-control", }),
        }


class MaterialsForm(ModelForm):
    class Meta:
        model = Materials
        fields = ('material', )
        widgets = {
        'material': forms.TextInput(attrs={'class': "form-control", })
        }


class CreateClientForm(forms.Form):
    surname = forms.CharField(widget=forms.TextInput(attrs={'class': 'form-control'}))
    first_name = forms.CharField(widget=forms.TextInput(attrs={'class': 'form-control'}))
    middle_name = forms.CharField(widget=forms.TextInput(attrs={'class': 'form-control'}))
    company_name = forms.CharField(widget=forms.TextInput(attrs={'class': 'form-control'}))
    create_account = forms.BooleanField(widget=forms.CheckboxInput(), required=False)
    email = forms.EmailField(widget=forms.TextInput(attrs={'class': 'form-control'}))
    requisites = forms.CharField(widget=forms.Textarea(attrs={'style': 'width: 100%;', 'class': 'form-control'}))
    phone = forms.CharField(widget=forms.TextInput(attrs={'class': 'form-control'}), required=False)
    delivery_address = forms.CharField(widget=forms.Textarea(attrs={'style': 'width: 100%;', 'class': 'form-control'}), required=False)


class CreateIndividualClientForm(forms.Form):
    surname = forms.CharField(widget=forms.TextInput(attrs={'class': 'form-control'}))
    first_name = forms.CharField(widget=forms.TextInput(attrs={'class': 'form-control'}))
    middle_name = forms.CharField(widget=forms.TextInput(attrs={'class': 'form-control'}))
    create_account = forms.BooleanField(widget=forms.CheckboxInput(), required=False)
    email = forms.EmailField(widget=forms.TextInput(attrs={'class': 'form-control'}))


class CreateClientAccountForm(forms.Form):
    email = forms.EmailField(widget=forms.TextInput(attrs={'class': 'form-control'}))
    password = forms.CharField(widget=forms.PasswordInput(attrs={'class': 'form-control'}))


class ClientsForm(forms.Form):
    clients = forms.ModelChoiceField(queryset=ClientProfile.objects.all(), widget=forms.Select(attrs={'class': 'form-control'}))


class AddOrdersForm(forms.Form):
    item = forms.ModelChoiceField(queryset=Item.objects.all(), widget=forms.Select(attrs={'class': 'form-control'}))
    size = forms.ModelChoiceField(queryset=Size.objects.all(), widget=forms.Select(attrs={'class': 'form-control'}))
    app_method = forms.ModelChoiceField(queryset=ApplicationMethod.objects.all(), widget=forms.Select(attrs={'class': 'form-control'}))
    material = forms.ModelChoiceField(queryset=Materials.objects.all(), widget=forms.Select(attrs={'class': 'form-control'}))
    quantity = forms.IntegerField(widget=forms.NumberInput(attrs={'class': 'form-control', 'v-model': 'quantity'}), initial=1)
    price = forms.FloatField(widget=forms.NumberInput(attrs={'class': 'form-control', 'v-model': 'price'}), initial=0.0)
    pre_payment = forms.FloatField(widget=forms.NumberInput(attrs={'class': 'form-control', 'v-model': 'prepayment'}), initial=0.0)
    info = forms.CharField(widget=forms.TextInput(attrs={'class': 'form-control'}), required=False)


class AddDocForm(forms.Form):
    title = forms.CharField(required=False, widget=forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'Наименование документа'}))
    discription = forms.CharField(required=False, widget=forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'Дополнительная информация'}))
    file = forms.FileField()
    

class AddingCostForm(forms.Form):
    title = forms.CharField(widget=forms.TextInput(attrs={'class': 'form-control addition_cost', 'placeholder': 'Наименование'}))
    cost = forms.IntegerField(widget=forms.NumberInput(attrs={'class': 'form-control addition_cost', 'placeholder': 'Стоимость'}))


class ProviderForm(ModelForm):
    class Meta:
        model = Provider
        fields = ('title', 'surname', 'first_name', 'middle_name', 'email', 'phone', 'requisites', 'address')
        widgets = {
            'title': forms.TextInput(attrs={'class': "form-control", }),
            'surname': forms.TextInput(attrs={'class': "form-control", }),
            'first_name': forms.TextInput(attrs={'class': "form-control", }),
            'middle_name': forms.TextInput(attrs={'class': "form-control", }),
            'email': forms.TextInput(attrs={'class': "form-control", }),
            'phone': forms.TextInput(attrs={'class': "form-control", }),
            'requisites': forms.Textarea(attrs={'class': "form-control", }),
            'address': forms.Textarea(attrs={'class': "form-control", }),
        }
    

class UploadDesign(forms.Form):
    image = forms.ImageField(widget=forms.FileInput(attrs={'class': 'mb-2'}))
    

class LogistForm(ModelForm):
    class Meta:
        model = LogisticsCompanies
        fields = ('title', 'surname', 'first_name', 'middle_name', 'email', 'phone', 'requisites')
        widgets = {
            'title': forms.TextInput(attrs={'class': "form-control", }),
            'surname': forms.TextInput(attrs={'class': "form-control", }),
            'first_name': forms.TextInput(attrs={'class': "form-control", }),
            'middle_name': forms.TextInput(attrs={'class': "form-control", }),
            'email': forms.TextInput(attrs={'class': "form-control", }),
            'phone': forms.TextInput(attrs={'class': "form-control", }),
            'requisites': forms.Textarea(attrs={'class': "form-control", }),
        }


class LogistPriceForm(ModelForm):
    class Meta:
        model = OrderNumber
        fields = ('logist_delivering',)
        widgets = {
            'logist_delivering': forms.NumberInput(),
        }
    

class ClientDocumentsForm(forms.ModelForm):
    class Meta:
        model = ClientDocuments
        fields = ('title', 'discription', 'file', 'client')
        widgets = {
            'title': forms.TextInput(attrs={'class': "form-control", }),
            'discription': forms.TextInput(attrs={'class': "form-control", }),
            'file': forms.FileInput(),
        }


class ClientBrandbookForm(forms.ModelForm):
    class Meta:
        model = ClientBrandbook
        fields = ('title', 'discription', 'file', 'client')
        widgets = {
            'title': forms.TextInput(attrs={'class': "form-control", }),
            'discription': forms.TextInput(attrs={'class': "form-control", }),
            'file': forms.FileInput(),
        }

    
class Design1Form(forms.ModelForm):
    class Meta:
        model = Design1
        fields = ('picture', 'confirm')
    

class Design2Form(forms.ModelForm):
    class Meta:
        model = Design2
        fields = ('picture', 'confirm')


class Design3Form(forms.ModelForm):
    class Meta:
        model = Design3
        fields = ('picture', 'confirm')


class Design4Form(forms.ModelForm):
    class Meta:
        model = Design4
        fields = ('picture', 'confirm')


class ManagerAddingCostForm(forms.ModelForm):
    class Meta:
        model = OrderNumber
        fields = ('manager_addition_cost',)
        widgets = {
            'manager_addition_cost': forms.NumberInput(),
        }


class DesignSpecificationForm(forms.ModelForm):
    class Meta:
        model = DesignSpecification
        fields = ('name', 'specification', 'picture')
        widgets = {
            'name': forms.TextInput(attrs={'class': "form-control", }),
            'specification': forms.TextInput(attrs={'class': "form-control", }),
        }

    
class LogistLinkForm(forms.ModelForm):
    class Meta:
        model = LogistLink
        fields = ('title', 'link')
    

class AddAgrForm(forms.ModelForm):
    class Meta:
        model = OrderNumber
        fields = ('add_agreement',)


class ContactAttachedForm(forms.ModelForm):
    class Meta:
        model = ClientProfile
        fields = ('contract_number', 'contract_attached')
        widgets = {
            'contract_attached': forms.CheckboxInput(),
        }


class OrderStatusForm(forms.ModelForm):
    class Meta:
        model = OrderNumber
        fields = ('status',)
    

class ProviderDocumentsForm(forms.ModelForm):
    class Meta:
        model = ProviderDocuments
        fields = ('title', 'discription', 'file')
        widgets = {
            'title': forms.TextInput(attrs={'class': "form-control", }),
            'discription': forms.TextInput(attrs={'class': "form-control", }),
        }


class FilesForProductionForm(forms.ModelForm):
    class Meta:
        model = FilesForProduction
        fields = ('discription', 'file')
        widgets = {
            'discription': forms.TextInput(attrs={'class': "form-control", }),
        }


class DesignFilesForProductionForm(forms.ModelForm):
    class Meta:
        model = DesignFilesForProduction
        fields = ('file',)


# Форма для изменения профиля клиента у КЛИЕНТА!!
# (Просто добавить необходимые поля в fields и потом во вьюхе передать экземпляр ClientProfile в форму и в темплейте можно править)
class ClientProfileForm(forms.ModelForm):
    class Meta:
        model = ClientProfile
        fields = ('label_info', 'email', 'phone')
        widgets = {
            'label_info': forms.Textarea(attrs={'class': "form-control", }),
            'email': forms.EmailInput(attrs={'class': "form-control", }),
            'phone': forms.TextInput(attrs={'class': "form-control", }),
        }
    

# Форма для изменения профиля клиента у Менеджера!!
# (Просто добавить необходимые поля в fields и потом во вьюхе передать экземпляр ClientProfile в форму и в темплейте можно править)    
class ClientProfileManagerForm(forms.ModelForm):
    class Meta:
        model = ClientProfile
        fields = ('label_info', 'email', 'phone', 'surname', 'first_name', 'middle_name', 'requisites', 'delivery_address', 'company')
        widgets = {
            'label_info': forms.Textarea(attrs={'class': "form-control", }),
            'email': forms.EmailInput(attrs={'class': "form-control", }),
            'phone': forms.TextInput(attrs={'class': "form-control", }),
            'surname': forms.TextInput(attrs={'class': "form-control", }),
            'first_name': forms.TextInput(attrs={'class': "form-control", }),
            'middle_name': forms.TextInput(attrs={'class': "form-control", }),
            'requisites': forms.Textarea(attrs={'class': "form-control", }),
            'delivery_address': forms.TextInput(attrs={'class': "form-control", }),
            'company': forms.TextInput(attrs={'class': "form-control", }),
        }


class DesignerTReqForm(forms.ModelForm):
    class Meta:
        model = DesignerTReq
        fields = ('technical_req', 'title')
        widgets = {
            'title': forms.TextInput(attrs={'class': "form-control", }),
            'technical_req': SummernoteWidget(),
        }
    
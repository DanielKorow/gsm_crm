from django.db import models
from django.contrib.auth.models import User


class ClientProfile(models.Model):

    class Meta:
        verbose_name = "ClientProfile"
        verbose_name_plural = "ClientProfiles"

    def __str__(self):
        return self.company

    user = models.ForeignKey(User, on_delete=models.SET_NULL, blank=True, null=True)

    company = models.CharField(blank=True, null=True, max_length=500)
    photo = models.ImageField(blank=True, null=True)
    surname = models.CharField(blank=True, null=True, max_length=500)
    first_name = models.CharField(blank=True, null=True, max_length=500)
    middle_name = models.CharField(blank=True, null=True, max_length=500)
    email = models.EmailField(blank=True, null=True)
    phone = models.CharField(blank=True, null=True, max_length=50)
    requisites = models.CharField(blank=True, null=True, max_length=3000)
    delivery_address = models.CharField(blank=True, null=True, max_length=3000)
    client_type = models.IntegerField()
    contract_number = models.CharField(null=True, blank=True, max_length=50)
    contract_attached = models.BooleanField(default=False)


class ClientDocuments(models.Model):

    class Meta:
        verbose_name = "Doc"
        verbose_name_plural = "Docs"

    def __str__(self):
        return self.file
    

    title = models.CharField(max_length=50)
    discription = models.CharField(max_length=3000, blank=True, null=True)
    file = models.FileField(upload_to='ClientDocuments', null=True)
    client = models.ForeignKey(ClientProfile, on_delete=models.SET_NULL, null=True, blank=True)


class OrderDocuments(models.Model):

    class Meta:
        verbose_name = "Doc"
        verbose_name_plural = "Docs"

    def __str__(self):
        pass
    

    title = models.CharField(max_length=50, blank=True, null=True)
    discription = models.CharField(max_length=3000, blank=True, null=True)
    file = models.FileField('OrderDocuments')
    order = models.ForeignKey('OrderNumber', on_delete=models.SET_NULL, null=True)


class Materials(models.Model):

    class Meta:
        verbose_name = "Материал"
        verbose_name_plural = "Материалы"

    def __str__(self):
        return self.material
    
    material = models.CharField(max_length=50, default="Нет")


class ApplicationMethod(models.Model):

    class Meta:
        verbose_name = "Метод нанесения"
        verbose_name_plural = "Методы нанесения"

    def __str__(self):
        return self.method

    method = models.CharField(max_length=50)


class Item(models.Model):

    class Meta:
        verbose_name = "Позиция"
        verbose_name_plural = "Позиции"

    def __str__(self):
        return self.name

    name = models.CharField(max_length=50)
    photo = models.ImageField(blank=True, null=True, upload_to='items')
    info = models.CharField(blank=True, null=True, max_length=5000)


class Size(models.Model):

    def __str__(self):
        return self.size

    size = models.CharField(blank=True, null=True, max_length=50)


class OrderNumberManager(models.Manager):
    def summary(self, id):
        result = 0
        order = OrderNumber.objects.get(id=id)
        for item in Order.objects.filter(order=order):
            result += item.summary
        return result

    def summary_with_adding(self, id):
        result = 0
        order = OrderNumber.objects.get(id=id)
        for item in Order.objects.filter(order=order):
            result += item.summary
        return result + order.manager_addition_cost

    @staticmethod
    def pre_payment(id):
        result = 0
        for item in Order.objects.filter(order=OrderNumber.objects.get(id=id)):
            result += item.pre_payment
        return result

    def post_payment(self, id):
        return self.summary(id) - self.pre_payment(id)


    def calculate_plan_of_delivery(self, id):
        return self.summary(id) * 0.02

    def calculate_designer_motivation(self, id):
        return self.summary(id) * 0.01

    def logist_price(self, id):
        price = 0
        order=OrderNumber.objects.get(id=id)
        for item in Order.objects.filter(order=order):
            price += item.delivering_price
        return price + order.logist_delivering

    def production_motivation(self, id):
        try:
            if self.order_margin(id) * 100 // self.summary(id) < 35:
                return 0
            if self.order_margin(id) * 100 // self.summary(id) in range(35,40):
                return self.summary(id) * 0.02
            if self.order_margin(id) * 100 // self.summary(id) in range(40,45):
                return self.summary(id) * 0.03
            if self.order_margin(id) * 100 // self.summary(id) in range(45,50):
                return self.summary(id) * 0.04
            if self.order_margin(id) * 100 // self.summary(id) in range(50,60):
                return self.summary(id) * 0.05
            if self.order_margin(id) * 100 // self.summary(id) in range(60,70):
                return self.summary(id) * 0.06
            if self.order_margin(id) * 100 // self.summary(id) in range(70,80):
                return self.summary(id) * 0.07
            if self.order_margin(id) * 100 // self.summary(id) in range(80,90):
                return self.summary(id) * 0.08
            if self.order_margin(id) * 100 // self.summary(id) in range(90,100):
                return self.summary(id) * 0.09
            if self.order_margin(id) * 100 // self.summary(id) > 100:
                return self.summary(id) * 0.1
        except:
            return 0

# Сделать стоимость логисту к каждой позиции
    def logist_difference(self, id):
        logist_delivering = OrderNumber.objects.get(id=id)
        return self.calculate_plan_of_delivery(id) - self.logist_price(id)

    def summary_entry(self, id):
        result = 0
        for item in Order.objects.filter(order=OrderNumber.objects.get(id=id)):
            result += item.summary_entry
        return result

    def order_margin(self, id):
        return self.summary(id) - self.summary_entry(id)


class OrderNumber(models.Model):

    class Meta:
        verbose_name = "Заказ"
        verbose_name_plural = "Заказы"

    def __str__(self):
        return str(self.client)

    user = models.ForeignKey(User, on_delete=models.SET_NULL, null=True)
    client = models.ForeignKey(ClientProfile, on_delete=models.SET_NULL, null=True)
    status_done = models.BooleanField(default=False)
    date = models.DateTimeField(auto_now_add=True)
    info = models.CharField(blank=True, null=True, max_length=5000)
    status = models.ForeignKey('ProductionStatus', on_delete=models.SET_NULL, null=True)
    logist_delivering = models.IntegerField(blank=True, null=True, default=0)
    manager_addition_cost = models.IntegerField(default=0)
    add_agreement = models.CharField(blank=True, null=True, max_length=50)


    objects = OrderNumberManager()


class Provider(models.Model):

    class Meta:
        verbose_name = "Поставщик"
        verbose_name_plural = "Поставщики"

    def __str__(self):
        return self.title
    
    title = models.CharField(max_length=500)
    surname = models.CharField(blank=True, null=True, max_length=500)
    first_name = models.CharField(blank=True, null=True, max_length=500)
    middle_name = models.CharField(blank=True, null=True, max_length=500)
    email = models.EmailField(blank=True, null=True)
    phone = models.CharField(blank=True, null=True, max_length=50)
    requisites = models.CharField(blank=True, null=True, max_length=10000)
    address = models.CharField(blank=True, null=True, max_length=5000)


class ProviderDocuments(models.Model):

    class Meta:
        verbose_name = "Документы поставщиков"
        verbose_name_plural = "Документы поставщиков"

    def __str__(self):
        return self.provider.title

    title = models.CharField(max_length=50, blank=True, null=True)
    discription = models.CharField(max_length=300, blank=True, null=True)
    file = models.FileField(upload_to='ProviderDocuments')
    provider = models.ForeignKey('Provider', on_delete=models.SET_NULL, null=True)    
    


class ProductionStatus(models.Model):

    class Meta:
        verbose_name = "ProductionStatus"
        verbose_name_plural = "ProductionStatuss"

    def __str__(self):
        return self.status
    
    status = models.CharField(blank=True, null=True, max_length=500)


class Order(models.Model):

    class Meta:
        verbose_name = "Order"
        verbose_name_plural = "Orders"

    def __str__(self):
        return self.item.name


    client = models.ForeignKey(ClientProfile, on_delete=models.SET_NULL, null=True) # Клиент
    item = models.ForeignKey(Item, on_delete=models.SET_NULL, null=True) # Позиция, связь
    material = models.ForeignKey(Materials, on_delete=models.SET_NULL, null=True, blank=True) # Материал
    app_method = models.ForeignKey(ApplicationMethod, on_delete=models.SET_NULL, null=True, blank=True) # Метод нанесения
    order = models.ForeignKey(OrderNumber, on_delete=models.SET_NULL, null=True) # Заказ, связь
    quantity = models.IntegerField(default=1, blank=True) # Кол-во
    design_img = models.ImageField(blank=True, null=True)  # Не используется
    size = models.ForeignKey(Size, on_delete=models.SET_NULL, null=True, blank=True) # Размер (не используется)
    provider = models.ForeignKey(Provider, on_delete=models.SET_NULL, null=True, blank=True) # Поставщик
    production_status = models.ForeignKey(ProductionStatus, on_delete=models.SET_NULL, null=True, blank=True) # Статус позици
    price = models.FloatField(blank=True, null=True) # Стоимости позиции
    pre_payment = models.FloatField(blank=True, null=True, default=0) # Предоплата по позиции
    shipping_company = models.ForeignKey('LogisticsCompanies', on_delete=models.SET_NULL, null=True, blank=True) # Транспортная компания
    weight = models.IntegerField(blank=True, null=True) # Вес
    volume = models.FloatField(blank=True, null=True) # Объём
    est_date = models.DateField(blank=True, null=True) # Дата доставки
    sending_date = models.DateField(blank=True, null=True) # Дата отправки
    production_purchase_price = models.FloatField(blank=True, null=True, default=0) # Цена закупки
    production_est_date = models.DateField(blank=True, null=True) # Дата готовности на производстве
    info = models.CharField(blank=True, null=True, max_length=10000) # Дополнительная информация по позиции
    design_specification = models.ForeignKey('DesignSpecification', on_delete=models.SET_NULL, null=True, blank=True) # Тех. требования
    design_requirements = models.CharField(blank=True, null=True, max_length=10000) # Тех. задание
    delivering_price = models.FloatField(blank=True, null=True, default=0) # Стоимость доставки
    designer_date = models.DateField(blank=True, null=True) # Дата готовности дизайна
    provider_pre_payment = models.FloatField(blank=True, null=True, default=0) # Предоплата поставщику

    def summary_entry(self):
        return self.production_purchase_price * self.quantity

    def summary(self):
        return self.quantity  * self.price

    def margin(self):
        return self.summary - self.summary_entry

    def margin_1item(self):
    	return float(self.price) - float(self.production_purchase_price)

    def post_payment(self):
        return self.quantity  * self.price - self.pre_payment

    def production_motivation(self):
        try:
            if self.margin_1item * 100 // self.price < 35:
                return 0
            if self.margin_1item * 100 // self.price in range(35,40):
                return self.summary * 0.02
            if self.margin_1item * 100 // self.price in range(40,45):
                return self.summary * 0.03
            if self.margin_1item * 100 // self.price in range(45,50):
                return self.summary * 0.04
            if self.margin_1item * 100 // self.price in range(50,60):
                return self.summary * 0.05
            if self.margin_1item * 100 // self.price in range(60,70):
                return self.summary * 0.06
            if self.margin_1item * 100 // self.price in range(70,80):
                return self.summary * 0.07
            if self.margin_1item * 100 // self.price in range(80,90):
                return self.summary * 0.08
            if self.margin_1item * 100 // self.price in range(90,100):
                return self.summary * 0.09
            if self.margin_1item * 100 // self.price > 100:
                return self.summary * 0.1
        except:
            return 0

    summary = property(summary)
    post_payment = property(post_payment)
    margin = property(margin)
    summary_entry = property(summary_entry)
    margin_1item = property(margin_1item)
    production_motivation = property(production_motivation)


class Cart(models.Model):

    class Meta:
        verbose_name = "Cart"
        verbose_name_plural = "Carts"

    def __str__(self):
        pass
    
    creation_date = models.DateTimeField()
    checked_out = models.BooleanField(default=False)


class TemporaryOrder(models.Model):

    class Meta:
        verbose_name = "TemporaryOrder"
        verbose_name_plural = "TemporaryOrders"

    def __str__(self):
        return self.item.name

    cart = models.ForeignKey(Cart, on_delete=models.CASCADE)
    item = models.ForeignKey(Item, on_delete=models.CASCADE)
    app_method = models.ForeignKey(ApplicationMethod, on_delete=models.CASCADE)
    material = models.ForeignKey(Materials, on_delete=models.CASCADE)
    quantity = models.PositiveIntegerField(verbose_name='quantity')
    client = models.ForeignKey(ClientProfile, on_delete=models.CASCADE)
    size = models.ForeignKey(Size, on_delete=models.CASCADE, blank=True, null=True)
    price = models.FloatField(blank=True, null=True)
    pre_payment = models.FloatField(blank=True, null=True)
    info = models.CharField(blank=True, null=True, max_length=3000)

    def total_price(self):
        return self.price * self.quantity

    total_price = property(total_price)


class OrderStatusManager(models.Manager):
    @staticmethod
    def add_status():
        status = ['Дизайн', 'Отправлен', 'Доставлен', 'Сборка']
        for stat in status:
            obj, create = OrderStatus.objects.get_or_create(status=stat)
        return obj


class OrderStatus(models.Model):

    class Meta:
        verbose_name = "OrderStatus"
        verbose_name_plural = "OrderStatus"

    def __str__(self):
        return self.status
    
    status = models.CharField(blank=True, null=True, max_length=50)

    objects = OrderStatusManager()


class AddingCost(models.Model):

    class Meta:
        verbose_name = "AddingCost"
        verbose_name_plural = "AddingCosts"

    def __str__(self):
        return self.title

    title = models.CharField(max_length=50)
    cost = models.FloatField()
    order = models.ForeignKey(OrderNumber, on_delete=models.SET_NULL, null=True)
    

class OrderComment(models.Model):

    class Meta:
        verbose_name = "OrderComment"
        verbose_name_plural = "OrderComments"

    def __str__(self):
        pass
    
    user = models.ForeignKey(User, on_delete=models.SET_NULL, null=True)
    comment = models.CharField(max_length=4000)
    order = models.ForeignKey(OrderNumber, on_delete=models.SET_NULL, null=True)


class DesignerOrder(models.Model):

    class Meta:
        verbose_name = "DesignerOrder"
        verbose_name_plural = "DesignerOrders"

    def __str__(self):
        pass
    
    item = models.ForeignKey(Item, on_delete=models.SET_NULL, null=True)
    material = models.ForeignKey(Materials, on_delete=models.SET_NULL, null=True)
    app_method = models.ForeignKey(ApplicationMethod, on_delete=models.SET_NULL, null=True)

 
class DesignImage(models.Model):

    class Meta:
        verbose_name = "DesignImage"
        verbose_name_plural = "DesignImages"

    def __str__(self):
        pass

    image = models.ImageField()
    position = models.ForeignKey(Order, on_delete=models.SET_NULL, null=True, blank=True)
    # position = models.ForeignKey(DesignerOrder, on_delete=models.SET_NULL, null=True, blank=True)
    confirm = models.BooleanField(default=False)


class DesignImageComment(models.Model):

    class Meta:
        verbose_name = "DesignImageComment"
        verbose_name_plural = "DesignImageComments"

    def __str__(self):
        return self.comment
    
    user = models.ForeignKey(User, on_delete=models.SET_NULL, null=True)
    comment = models.CharField(blank=True, null=True, max_length=2500)
    position = models.ForeignKey(Order, on_delete=models.SET_NULL, null=True)
    design = models.ImageField(blank=True, null=True, upload_to='design_images')
    # position = models.ForeignKey(DesignerOrder, on_delete=models.SET_NULL, null=True)


class LogisticsCompanies(models.Model):

    class Meta:
        verbose_name = "Логистическая компания"
        verbose_name_plural = "Логистические компании"

    def __str__(self):
        return self.title

    title = models.CharField(max_length=50)
    surname = models.CharField(blank=True, null=True, max_length=500)
    first_name = models.CharField(blank=True, null=True, max_length=500)
    middle_name = models.CharField(blank=True, null=True, max_length=500)
    email = models.EmailField(blank=True, null=True)
    phone = models.CharField(blank=True, null=True, max_length=50)
    requisites = models.CharField(blank=True, null=True, max_length=5000)
    address = models.CharField(blank=True, null=True, max_length=6000) 


class LogistLink(models.Model):

    class Meta:
        verbose_name = "LogistLink"
        verbose_name_plural = "LogistLinks"

    def __str__(self):
        pass
    
    title = models.CharField(blank=True, null=True, max_length=200)
    link = models.URLField(blank=True, null=True)


# Новый вариант для дизайнера
class Design1(models.Model):

    class Meta:
        verbose_name = "Design1"
        verbose_name_plural = "Design1s"

    def __str__(self):
        pass
    
    picture = models.ImageField(null=True, blank=True, upload_to="Picture_design/Desing_1")
    confirm = models.BooleanField(blank=True)
    position = models.ForeignKey(Order, on_delete=models.SET_NULL, null=True, blank=True)


class Design1_comment(models.Model):

    class Meta:
        verbose_name = "Design1_comment"
        verbose_name_plural = "Design1_comments"

    def __str__(self):
        pass

    design = models.ForeignKey(Design1, on_delete=models.SET_NULL, null=True)
    picture = models.ImageField(blank=True, null=True, upload_to="Picture_comment/Desing_1")
    comment = models.CharField(blank=True, null=True, max_length=5000)
    user = models.ForeignKey(User, on_delete=models.SET_NULL, null=True)
    

class Design2(models.Model):

    class Meta:
        verbose_name = "Design2"
        verbose_name_plural = "Design2s"

    def __str__(self):
        pass
    
    picture = models.ImageField(null=True, blank=True, upload_to="Picture_design/Desing_2")
    confirm = models.BooleanField(blank=True)
    position = models.ForeignKey(Order, on_delete=models.SET_NULL, null=True, blank=True)


class Design2_comment(models.Model):

    class Meta:
        verbose_name = "Design2_comment"
        verbose_name_plural = "Design2_comments"

    def __str__(self):
        pass

    design = models.ForeignKey(Design1, on_delete=models.SET_NULL, null=True)
    picture = models.ImageField(blank=True, null=True, upload_to="Picture_comment/Desing_2")
    comment = models.CharField(blank=True, null=True, max_length=5000)
    user = models.ForeignKey(User, on_delete=models.SET_NULL, null=True)


class Design3(models.Model):

    class Meta:
        verbose_name = "Design3"
        verbose_name_plural = "Design3s"

    def __str__(self):
        pass
    
    picture = models.ImageField(null=True, blank=True, upload_to="Picture_design/Desing_3")
    confirm = models.BooleanField(blank=True)
    position = models.ForeignKey(Order, on_delete=models.SET_NULL, null=True, blank=True)


class Design3_comment(models.Model):

    class Meta:
        verbose_name = "Design3_comment"
        verbose_name_plural = "Design3_comments"

    def __str__(self):
        pass

    design = models.ForeignKey(Design1, on_delete=models.SET_NULL, null=True)
    picture = models.ImageField(blank=True, null=True, upload_to="Picture_comment/Desing_3")
    comment = models.CharField(blank=True, null=True, max_length=5000)
    user = models.ForeignKey(User, on_delete=models.SET_NULL, null=True)


class Design4(models.Model):

    class Meta:
        verbose_name = "Design4"
        verbose_name_plural = "Design4s"

    def __str__(self):
        pass
    
    picture = models.ImageField(null=True, blank=True, upload_to="Picture_design/Desing_4")
    confirm = models.BooleanField(blank=True)
    position = models.ForeignKey(Order, on_delete=models.SET_NULL, null=True, blank=True)


class Design4_comment(models.Model):

    class Meta:
        verbose_name = "Design4_comment"
        verbose_name_plural = "Design4_comments"

    def __str__(self):
        pass

    design = models.ForeignKey(Design1, on_delete=models.SET_NULL, null=True)
    picture = models.ImageField(blank=True, null=True, upload_to="Picture_comment/Desing_4")
    comment = models.CharField(blank=True, null=True, max_length=5000)
    user = models.ForeignKey(User, on_delete=models.SET_NULL, null=True)
# Кончился новый вариант для дизайнера


class DesignSpecification(models.Model):

    class Meta:
        verbose_name = "DesignSpecification"
        verbose_name_plural = "DesignSpecifications"

    def __str__(self):
        return self.name

    name = models.CharField(blank=True, null=True, max_length=200)
    specification = models.CharField(blank=True, null=True, max_length=10000)
    picture = models.FileField(blank=True, null=True, upload_to='specifications')


class FilesForProduction(models.Model):

    class Meta:
        verbose_name = "files for production"
        verbose_name_plural = "files for productions"

    def __str__(self):
        return self.discription
    
    order = models.ForeignKey(OrderNumber, on_delete=models.SET_NULL, null=True)
    discription = models.CharField(blank=True, null=True, max_length=6000)
    file = models.FileField()
    

class DesignFilesForProduction(models.Model):

    class Meta:
        verbose_name = "DesignFilesForProduction"
        verbose_name_plural = "DesignFilesForProductions"

    def __str__(self):
        pass
    
    position = models.ForeignKey(Order, on_delete=models.SET_NULL, null=True, blank=True)
    file = models.FileField()
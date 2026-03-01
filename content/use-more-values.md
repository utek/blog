---
title: Use more values
date: 2021-11-12
tags: python, django
category: programming
author: Łukasz Bołdys
---

While working with Django ORM very often `.only()` is used to speed up DB query.
Unfortunately is also opens code to some nasty db queries related bugs.
Let's for example take simple model:

```python
class Foo(models.Model):

    field_a = models.CharField(max_length=16)
    field_b = models.CharField(max_length=50)
    field_c = models.BooleanField()
```

Everything looks good here. Now we have a developer that should implement
listing of all the names of model `Foo`. As they are thinking about performance
they use "[only](https://docs.djangoproject.com/en/3.2/ref/models/querysets/#django.db.models.query.QuerySet.only)" to limit size of the query (Django ORM will query only for
the mentioned field).

```python
def some_view():
    ret = []
    foos = Foo.object.all().only("field_a")
    for foo in foos:
        ret.append({"field_name": foo.field_a})
    return ret
```

And everybody is happy. This view is making one query to db that returns only
the required data.

But after few weeks new feature is added that need also `field_b` value.
This task is being taken by some other developer. So they jump into code
and modify the view to look like this:

```python
def some_view():
    ret = []
    foos = Foo.object.all().only("field_a")
    for foo in foos:
        ret.append({"field_name": foo.field_a, "field_bool": foo.field_b})
    return ret
```

Code is working. Great work. But because new dev didn't notice `.only("field_a")`
or was not experienced enough to know what it does. But the code is working.
Test were adjusted to get new return dicts. Things are well. Or are they?
Because that simple oversight view that was generating one query to db is
generating now `n` queries, where `n` is number of `Foo` instances. And that can
get big pretty fast.

"But that should be caught by code review" you can say. Yes. You would be right,
but unfortunately we are people. We make mistakes. It's very easy to miss that
especially if the queryset is build way earlier in the code.

I think it's better to use `values_list` or `values` in such situations.
Not only they are faster and take less memory (as instances of Foo model doesn't
have to be created), but they are also protect you in a way from making such
mistake.

For example this code:

```python
def some_view():
    ret = []
    foos = Foo.object.all().values_list("field_a", "field_b", named=True)
    for foo in foos:
        ret.append({"field_name": foo.field_a, "field_bool": foo.field_b})
    return ret
```

will be faster and will also cause exception to be thrown in case somebody
tries to access `field_c` on `foo`.

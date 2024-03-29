---
title: 'لينكس: تبي تحيرة خيرة'
author: Rayed
type: post
date: 2008-05-24T20:29:59+03:00
wp_direction:
  - rtl
categories:
  - Uncategorized
tags:
  - arabic
  - debian
  - gentoo
  - linux
  - redhat
wordpress_id: 391

---

**تحديث فبراير ٢٠٢٢ :**

بعد تغيير سياسة Centos في التحديث، قررت التحويل الى ديبيان
توزيعة ديبيان خفيفة ورشيقة مقارنة باوبنتو، ومجانية وتحديثاتها آمنة


**تحديث ١٢ اكتوبر ٢٠١٨:**

حولت بالكامل لسينوتس CentOS متوافق مع رد هات لكن مجاني.

**تحديث ٢٩ اغسطس ٢٠١٣:**

حاليا الخيار بالنسبة لي اوضح كثيرا، فهو ينحصر في اوبنتو Ubuntu خصوصا نسخة الخادمات، او سينتوس CentOS اذا احتجت توافقية مع RedHat.

**الموضوع الاصلي**

من اهم نقاط الضعف في نظام لينكس هي تعدد التوزيعات، مما يخلق حيرة في اختيار التوزيعة المناسبة حتى لدى خبرء يونكس، فعلى الرغم من اني مدمن انظمة يونكس منذ اكثر من عشر سنوات الا اني لا ازال احتار عند العمل مع لينكس، وهذه احد اهم الاسباب التي تجعلني افضل نظام فري بي اس دي (FreeBSD)، حيث لا يوجد سوى نظام تشغيل واحد فقط لا غير، واذا بحثت عن حل مشكلة في فري بي اس دي ستعرف انها سوف تعمل لانه لا يوجد سوى نظام واحد اسمه قري بي اس دي. طبعاً اذا اخترت توزيعة لينكس وبقيت عليها فانك تحصل على نفس الفائدة، لكن يبقى التشتيت مستمراً من قبل التوزيعات الثانية التي يظهر فيها مزايا جديدة من هنا وهناك.

ما قادني الى هذا الموضوع هو احتياج العمل الحالي الى انظمة لينكس، وتبقى عملية الاحتيار، اقصد الاختيار. على الرغم من الاختيار شبة محسوم لصالح رد هات لينكس (Red Hat) لدعمه برامج اوراكل ودعم اوراكل له، لكن تبقى الخيارات الاخرى مغرية جداً، ولذيذة.

<img src="http://www.debian.org/logos/openlogo-100.png" align="left" />

فتوزيعة ديبيان (Debian) تغريك بكمية البرامج الجاهزة للتركيب والتي تتجاوز 18000 برنامج، كما ان التوزيعة مستقرة للغاية ومناسبة جداً للخادمات، وتجعل تحديث نظام التشغيل والبرامج سهل للغاية، وللأسف هذا الاستقرار يعني ان البرامج قد تكون قديمة بعض الشئ. توزيعة اوبنتو (Ubuntu) مبنية على ديبيان، لكن لا ادري ماهي المزايا التي يقدمها اكثر من ديبيان، الدعم الفني بالطبع احد اهم المزايا لكني متأكد انها ليست الوحيدة.

رد هات من ناحية اخرى يتمتع بدعم غير مسبوق من جميع الشركات الاخرى، فمعظم شركات البرامج تجعل من دعم رد هات من اهم اولوياتها، حتى ان اوراكل تقدم دعم رد هات بشكل مباشر. يعيب على رد هات السعر طبعاً، فهو ليس مجاني، لكن اذا لم تحتاج الى الدعم الفني او حبيت تبني انظمة اختبار او تطوير يمكن استبدال رد هات لينكس بنظام سينتوس (CentOS) وهو نسخة متوافقة 100% مع ردهات.

مشكلة ردهات هي قلة البرامج في مستودع البرامج الرئيسي، على الرغم من اماكنية زيادة البرامج باستخدام مستودعات برامج اضافية مثل: rpmforge و EPEL.

<a href='/static/uploads/2008/05/glogo-smallpng.jpg'><img src="/static/uploads/2008/05/glogo-smallpng.jpg" alt="" title="glogo-smallpng" width="146" height="149" class="alignleft size-medium wp-image-392" /></a>

التوزيعة الاخيرة التي اثارت اهتمامي هي توزيعة جينتو (Gentoo)، مع اني لم اجربها بالشكل الملائم، الا ان هناك عدة نقاط اثارت اهتمامي، اولاً: طريقة التركيب تجبرك على فهم نظام التشغيل وكيفية عمل لينكس بشكل اكبر، النقطة الثانية هي استخدام ما يسمى بالبورتاج "Portage" وهي نفس طريقة البورت "Port" في فري بس اس دي. وهي طريقة تركيب البرامج عن طريق بناءها من المصدر، بحيث يتم تحديد مصدر البرنامج، وتحديد الباتش المطلوبة، والمتغيرات المطلوبة ليتم تركيب البرنامج بطريقة متلائمة مع نظام التشغيل. يعيب على هذه الطريقة طول الوقت اللازم لتركيب البرامج، لكنها تتميز بأنك تحصل افضل سرعة ممكنة، والخصائص المطلوبة بدون زيادة او نقصان. طول الوقت قد لايكون مشكلة في الخادمات لقلة البرامج المركبة فيها، اما اذا اردت بناء كمبيوتر مكتبي فعليك التحلي بالصبر.

اذا كان لديك خبرة في توزيعات لينكس، خصوصاً الخاصة بالخادمات، ارجوا ان تشاركني رأيك.


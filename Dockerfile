# استخدام أوبونتو
FROM ubuntu:22.04

# منع النوافذ التفاعلية أثناء التثبيت
ENV DEBIAN_FRONTEND=noninteractive

<<<<<<< HEAD
# تثبيت Octave ومكتبات التطوير، و sympy، وأداة ttyd الأحدث لدعم الموبايل
=======
# تثبيت Octave ومكتبات التطوير، و sympy، وأداة ttyd الأحدث بدلاً من gotty
>>>>>>> 262c3447380ea05b80b2618de274d049e96054f9
RUN apt-get update && apt-get install -y \
    octave \
    liboctave-dev \
    python3-sympy \
    ttyd \
    make \
    && rm -rf /var/lib/apt/lists/*

# تثبيت الحزمة الرمزية (symbolic)
RUN octave --no-gui --eval "pkg install -forge symbolic"

# تحديد مسار العمل
WORKDIR /app

# نسخ كود المشروع
COPY matricesgradution.m .

# فتح البورت 8080 للويب
EXPOSE 8080

<<<<<<< HEAD
# تشغيل خادم ttyd 
# إضافة حرف -i لبرنامج octave لتفعيل الأسهم (Interactive Mode)
CMD ["ttyd", "-W", "-p", "8080", "octave", "-i", "--no-gui", "--eval", "matricesgradution"]
=======
# تشغيل خادم ttyd الذي سيعرض واجهة Octave للمستخدم ويدعم الموبايل
# حرف W الكبير يسمح للمستخدم بالكتابة والتفاعل
CMD ["ttyd", "-W", "-p", "8080", "octave", "--no-gui", "--eval", "matricesgradution"]
>>>>>>> 262c3447380ea05b80b2618de274d049e96054f9

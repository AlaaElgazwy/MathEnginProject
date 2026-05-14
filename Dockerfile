# استخدام أوبونتو
FROM ubuntu:22.04

# منع النوافذ التفاعلية أثناء التثبيت
ENV DEBIAN_FRONTEND=noninteractive

# تثبيت Octave ومكتبات التطوير، و sympy، وأداة ttyd الأحدث بدلاً من gotty
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

# تشغيل خادم ttyd الذي سيعرض واجهة Octave للمستخدم ويدعم الموبايل
# حرف W الكبير يسمح للمستخدم بالكتابة والتفاعل
CMD ["ttyd", "-W", "-p", "8080", "octave", "--no-gui", "--eval", "matricesgradution"]

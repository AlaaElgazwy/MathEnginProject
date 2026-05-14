# استخدام أوبونتو
FROM ubuntu:22.04

# منع النوافذ التفاعلية أثناء التثبيت
ENV DEBIAN_FRONTEND=noninteractive

# تثبيت Octave ومكتباته، بالإضافة إلى أداة wget لتحميل GoTTY
RUN apt-get update && apt-get install -y \
    octave \
    octave-symbolic \
    python3-sympy \
    wget \
    && rm -rf /var/lib/apt/lists/*

# تحميل وتثبيت أداة GoTTY (لتحويل الـ Terminal إلى صفحة ويب)
RUN wget https://github.com/yudai/gotty/releases/download/v1.0.1/gotty_linux_amd64.tar.gz \
    && tar -zxvf gotty_linux_amd64.tar.gz \
    && mv gotty /usr/local/bin/ \
    && rm gotty_linux_amd64.tar.gz

# تحديد مسار العمل
WORKDIR /app

# نسخ كود المشروع
COPY matricesgradution.m .

# فتح البورت 8080 للويب
EXPOSE 8080

# تشغيل خادم GoTTY الذي سيعرض واجهة Octave للمستخدم
# حرف w يعني السماح للمستخدم بالكتابة (التفاعل مع البرنامج)
CMD ["gotty", "-w", "-p", "8080", "octave", "--no-gui", "--eval", "matricesgradution"]

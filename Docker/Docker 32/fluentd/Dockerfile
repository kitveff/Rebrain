FROM fluent/fluentd:v1.15-1

# Переключение на пользователя root для установки плагинов
USER root

# Установка плагина elasticsearch
RUN gem install fluent-plugin-elasticsearch

# Копирование конфигурационного файла
COPY conf/fluentd.conf /fluentd/etc/fluentd.conf

# Запуск Fluentd
CMD ["fluentd"]
FROM chatwoot/chatwoot:v2.5.0

RUN gem install bundler
ENV NODE_ENV production
ENV RAILS_ENV production
ENV INSTALLATION_ENV docker
ENV ACTIVE_STORAGE_SERVICE amazon
ENV RAILS_MAX_THREADS 2
ENV PORT 3000
ENV CHATWOOT_PREPARE false

ADD bin/w3b.sh /bin/w3b.sh

ADD bin/add_external_source_ids_whatsapp.rb /app/lib/add_external_source_ids_whatsapp.rb
RUN echo "$(cat /app/lib/add_external_source_ids_whatsapp.rb)" >> /app/config/application.rb
RUN rm /app/lib/add_external_source_ids_whatsapp.rb

ADD bin/message_builder_patch.rb /app/lib/message_builder_patch.rb
RUN echo "$(cat /app/lib/message_builder_patch.rb)" >> /app/config/application.rb
RUN rm /app/lib/message_builder_patch.rb

CMD ["sh", "/bin/w3b.sh"]
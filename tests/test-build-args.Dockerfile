# a simple container that takes 3 args and generate a shell script that prints them
FROM alpine:3.12.0

ARG ARG_1=default_1
ARG ARG_2=default_2
ARG ARG_3=default_3

RUN echo "#!/bin/sh" > /script.sh
RUN echo "echo \"arg-1=$ARG_1\" | tee /output" >> /script.sh
RUN echo "echo \"arg-2=$ARG_2\" | tee /output" >> /script.sh
RUN echo "echo \"arg-3=$ARG_3\" | tee /output" >> /script.sh
# also echo the shell args
RUN echo "for arg in \"\$@\"" >> /script.sh
RUN echo "do" >> /script.sh
RUN echo "  echo \"arg: \$arg\"" >> /script.sh
RUN echo "done" >> /script.sh

RUN chmod +x /script.sh

ENTRYPOINT ["/script.sh"]
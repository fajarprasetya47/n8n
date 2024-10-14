FROM node:20-slim

# ARG NODE_SNAP=false

# RUN apt-get update && apt-get install -y dos2unix

# Change working directory
RUN mkdir /app
WORKDIR /app

RUN apt-get update && apt-get install -y build-essential python-is-python3
RUN apt-get update && apt-get install -y curl
RUN apt-get update && apt-get install -y git

# Clone FUXA repository
RUN git clone https://github.com/fajarprasetya47/n8n.git

# Install build dependencies for node-odbc
# RUN apt-get update && apt-get install -y build-essential python3
# Convert the script to Unix format and make it executable
# RUN dos2unix FUXA/odbc/install_odbc_drivers.sh && chmod +x FUXA/odbc/install_odbc_drivers.sh

RUN curl -I https://registry.npmjs.org

# WORKDIR /usr/src/app/FUXA/odbc
# RUN ./install_odbc_drivers.sh

# Change working directory
# WORKDIR /usr/src/app

# Copy odbcinst.ini to /etc
# RUN cp FUXA/odbc/odbcinst.ini /etc/odbcinst.ini

# RUN corepack enable
# RUN corepack prepare pnpm@9.6.0 --activate
RUN npm install -g pnpm

# Install Fuxa server
WORKDIR /app/n8n
RUN pnpm install
RUN pnpm build

# Install options snap7
# RUN if [ "$NODE_SNAP" = "true" ]; then \
#     npm install node-snap7; \
#     fi

# Workaround for sqlite3 https://stackoverflow.com/questions/71894884/sqlite3-err-dlopen-failed-version-glibc-2-29-not-found
# RUN apt-get update && apt-get install -y sqlite3 libsqlite3-dev && \
#     apt-get autoremove -yqq --purge && \
#     apt-get clean  && \
#     rm -rf /var/lib/apt/lists/*  && \
#     npm install --build-from-source --sqlite=/usr/bin sqlite3

# Add project files
# ADD . /usr/src/app/FUXA

# Set working directory
# WORKDIR /usr/src/app/FUXA/server

# Expose port
EXPOSE 5678

# Start the server
CMD [ "pnpm", "start" ]

FROM codercom/code-server:latest

# Install necessary packages
RUN apt-get update && apt-get install -y \
    curl \
    python3 \
    python3-pip

# Set the working directory
WORKDIR /home/coder

# Install pipenv globally
RUN pip3 install pipenv

# Copy your project files into the container
COPY ./ /home/coder

# Change ownership of the copied files
RUN chown -R coder:coder /home/coder

# Install dependencies using pipenv
RUN pipenv install --deploy --ignore-pipfile

# Expose the port for the code-server
EXPOSE 8080

# Start the code-server as the 'coder' user
USER coder
CMD ["code-server", "--bind-addr", "0.0.0.0:8080", "--auth", "1"]
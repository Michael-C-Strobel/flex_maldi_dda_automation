# existing Dockerfile
FROM python:3.11

# Set a working directory
WORKDIR /app

# Prevent Python from writing pyc files and buffer stdout/stderr
# ENV PYTHONDONTWRITEBYTECODE=1
# ENV PYTHONUNBUFFERED=1

# Install system dependencies needed for some packages (lxml, pyopenms, tkinter for file dialogs, build tools)
RUN apt-get update && apt-get install -y --no-install-recommends \
	build-essential \
	git \
	curl \
	ca-certificates \
	libxml2-dev \
	libxslt1-dev \
	libopenjp2-7 \
	libgl1 \
	libglib2.0-0 \
	xvfb \
	libffi-dev \
	libpng-dev \
	pkg-config \
	tk \
	tcl \
	libsm6 \
	libxrender1 \
	libxext6 \
	&& rm -rf /var/lib/apt/lists/*

# More installs
RUN apt-get update && \
    apt-get install -y xvfb x11-xkb-utils x11-utils x11-xserver-utils xauth && \
    rm -rf /var/lib/apt/lists/*

# Copy only requirements first
COPY requirements.txt /app/

# Upgrade pip and install dependencies
RUN pip install --upgrade pip setuptools wheel
RUN if [ -f requirements.txt ]; then pip install --no-cache-dir -r requirements.txt; fi

# Copy the rest of the project files
COPY . /app

# Install the package itself
RUN pip install --no-cache-dir .

# Pip
RUN pip install git+https://github.com/gtluu/pyTDFSDK.git
RUN pip install git+https://github.com/gtluu/pymaldiproc.git


# Expose Dash default port
EXPOSE 8050

# Use a simple entrypoint to run the provided script. The project starts a webview window via pywebview
# which is not usable inside a container; the Dash app is exposed by msms_autox_generator.gui when run directly.
CMD ["python", "fleX_MSMS_AutoXecute_Generator.py"]

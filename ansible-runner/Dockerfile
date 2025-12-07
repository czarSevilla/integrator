# Usa una imagen base ligera de Python, ya que Ansible es una aplicación Python.
# Puedes elegir una versión específica de Python si es necesario, por ejemplo, python:3.9-slim-buster
FROM python:3-slim-buster

# Establece el directorio de trabajo dentro del contenedor
WORKDIR /ansible

# Instala Ansible
# Usamos pip para instalar Ansible y nos aseguramos de que sea la última versión estable.
RUN pip install ansible

# (Opcional) Instala colecciones de Ansible si las necesitas para tus playbooks
# Por ejemplo, para colecciones de Windows:
RUN ansible-galaxy collection install community.general

# (Opcional) Copia el archivo ansible.cfg si tienes configuraciones personalizadas
# Si no tienes un ansible.cfg específico, Ansible usará su configuración predeterminada.
# COPY ansible.cfg /etc/ansible/ansible.cfg

# Define el punto de montaje para tus playbooks y archivos de inventario
# Este es el directorio dentro del contenedor donde montarás tu volumen host.
VOLUME /ansible/playbooks

# Comando predeterminado para el contenedor
# Esto te da un shell interactivo dentro del contenedor para ejecutar comandos Ansible.
# Puedes sobrescribirlo al ejecutar el contenedor para ejecutar un playbook específico.
CMD ["bash"]

# Para ejecutar un playbook directamente al iniciar el contenedor, podrías cambiar CMD a:
# CMD ["ansible-playbook", "/ansible/playbooks/your_playbook.yml", "-i", "/ansible/playbooks/inventory.ini"]
# Asegúrate de que los archivos existan en el volumen montado.
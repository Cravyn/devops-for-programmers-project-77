.PHONY: requirements tf-setup-backend tf-create tf-destroy deploy encrypt-vault edit-vault

requirements:
	ansible-galaxy install -c requirements.yml -r requirements.yml

tf-setup-backend:
	ansible-playbook ansible/playbook_setup.yml --vault-password-file ansible/.password

tf-create:
	ansible-playbook ansible/playbook_tf.yml --vault-password-file ansible/.password --extra-vars "terraform_state=present"

tf-destroy:
	ansible-playbook ansible/playbook_tf.yml --vault-password-file ansible/.password -t terraform --extra-vars "terraform_state=absent"

deploy:
	ansible-playbook -i ansible/inventory.ini ansible/playbook.yml --vault-password-file ansible/.password

encrypt-vault:
	ansible-vault encrypt ansible/group_vars/all/vault.yml
	
edit-vault:
	ansible-vault edit ansible/group_vars/all/vault.yml

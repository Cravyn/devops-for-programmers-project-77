.PHONY: requirements prepare deploy

requirements:
	ansible-galaxy install -c requirements.yml -r requirements.yml

tf-setup-backend:
	ansible-playbook ansible/playbook_setup.yml --vault-password-file ansible/.password

tf-create:
	ansible-playbook ansible/playbook_tf.yml --vault-password-file ansible/.password --extra-vars "terraform_state=present"

tf-destroy:
	ansible-playbook ansible/playbook_tf.yml --vault-password-file ansible/.password -t terraform --extra-vars "terraform_state=absent"

tf-unlock:
	ansible-playbook ansible/playbook_tf.yml --vault-password-file ansible/.password -t unlock

deploy:
	ansible-playbook -i ansible/inventory.ini ansible/playbook.yml --vault-password-file ansible/.password

edit-vault:
	ansible-vault edit ansible/group_vars/all/vault.yml

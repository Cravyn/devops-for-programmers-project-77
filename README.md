### Hexlet tests and linter status:
[![Actions Status](https://github.com/Cravyn/devops-for-programmers-project-77/actions/workflows/hexlet-check.yml/badge.svg)](https://github.com/Cravyn/devops-for-programmers-project-77/actions)

### Требования

- Ansible
- Terraform
- make

### Шаг 0. Подготовка (на примере VK Cloud)

1. Создать аккаунт, настроить работу с проектом через CLI, получить данные для авторизации в провайдере Terraform.
2. Добавьте значения логина (MCS_LOGIN), пароля (MCS_PASS) и ID проекта (MCS_PID) в `ansible/group_vars/all/vault.yml`.
3. Создайте и загрузите в KMS TLS-сертификат для желаемого домена. В проекте используется домен cravyn.ru.
4. Добавьте название TLS-сертификата (CERT_NAME) в `ansible/group_vars/all/vault.yml`.
5. Создайте ключевую пару и укажите путь к ней в переменной `SSH_KEY_PATH` в `ansible/group_vars/all/vault.yml`.
6. Создатйте БД PostgreSQL для хранения состояния Terraform.
7. Внесите в `ansible/group_vars/all/vault.yml` данные для подключения к ней:
    - STATE_POSTGRESQL_HOST - адрес хоста БД
    - STATE_POSTGRESQL_DB - название БД
    - STATE_POSTGRESQL_USER - имя пользователя
    - STATE_POSTGRESQL_PASSWORD - пароль пользователя
    - STATE_POSTGRESQL_PORT - порт для подключения к БД
8. Укажите желаемые значения переменных для:
    - REDMINE_PORT - адреса порта для приложения Redmine
    - POSTGRESQL_DB - имя БД Redmine
    - POSTGRESQL_USER - имя пользователя
    - POSTGRESQL_PASSWORD - пароль пользователя
    - POSTGRESQL_PORT - порт для подключения к БД
9. Создайте аккаунт в DataDog. Создайте API Key и App Key в своем аккаунте.
10. Добавьте значения API Key (DATADOG_API_KEY), App Key (DATADOG_APP_KEY) и адрес сайта API DataDog (DATADOG_SITE) для региона вашего аккаунта в `ansible/group_vars/all/vault.yml`.

### Шаг 1. Настройка

1. Установите зависимости Ansible: `make install_requirements`.
2. Зашифруйте Anisble vault: `make encrypt-vault`.
3. Создайте файл с паролем хранилища `./ansible/.password` для удобства работы.

### Шаг 2. Настройка удаленного бэкенда для состояния Terraform

1. Выполните команду `make tf-setup-backend`

### Шаг 3. Создание инфраструктуры

1. Выполните команду `make tf-create`

### Шаг 4. Деплой приложения

1. Выполните команду `make deploy`

#### URL проекта

`https://cravyn.ru/`

## Команды Make commands
- `make requirements` - установка зависимостей Ansible
- `make tf-setup-backend` - настройка удаленного бэкенда для состяния Terraform
- `make tf-create` - создание инфраструктуры
- `make tf-destroy` - удаление инфраструктуры
- `make deploy` - деплой приложения Redmine в инфраструктуру
- `make encrypt-vault` - зашифровать Ansible vault
- `make edit-vault` - открыть Ansible vault для редактирования

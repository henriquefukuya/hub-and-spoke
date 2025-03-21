# Provisionamento de uma Rede Hub and Spoke no Azure

⚠️ Este repositório tem como objetivo apenas validar os conhecimentos técnicos ao qual estou adquirindo no momento:

📝  Azure (Cloud)

📝  Terraform (IaC)

📝  Git (repositório e comandos)

📝  GitHub Actions (pipeline)

📝  VScode (linhas de código)

📝  Copilot/ChatGPT (criação dos scripts)


# O que é uma rede Hub and Spoke?

ℹ️ A arquitetura Hub and Spoke é um modelo de rede em que um componente central (Hub) gerencia e conecta múltiplos componentes periféricos (Spokes). Esse modelo é amplamente utilizado em redes corporativas e em arquiteturas de nuvem, para otimizar conectividade, segurança e gerenciamento de tráfego.


# Vantagens do modelo Hub and Spoke

✅ Segurança aprimorada – Centraliza controle de tráfego e aplicação de políticas de segurança no Hub.

✅ Otimização de custos – Reduz a necessidade de conexões diretas entre todas as redes, minimizando gastos com tráfego.

✅ Gerenciamento eficiente – Facilita monitoramento e administração da rede.

✅ Escalabilidade – Permite adicionar novos Spokes sem grandes mudanças na infraestrutura.


# Passo a passo para provisionar a infra

1) Criar um repositório no Git;
2) Criar o arquivo main.tf
3) Criar o diretório .github/workflows
4) No diretório criado, criar o arquivo terraform.yaml
5) Realizar a autenticação do Azure Login (via bash) e criar um Service Principal:
   
   az ad sp create-for-rbac --name "terraform-sp" --role="Contributor" --scopes="/subscriptions/<SUBSCRIPTION_ID>" --sdk-auth

Copiar as informações do arquivo de saída (json) conforme abaixo:

{
  "clientId": "NOVO_ARM_CLIENT_ID",
  "clientSecret": "NOVO_ARM_CLIENT_SECRET",
  "subscriptionId": "NOVO_ARM_SUBSCRIPTION_ID",
  "tenantId": "NOVO_ARM_TENANT_ID"
}

7) No repositório do Git, vá em Settings → Secrets and variables → Actions → New Repository e crie um repositório com o nome de AZURE_CREDENTIALS, inserindo as informações do arquivo json copiado acima;
8) Crie outro repositório com o nome de SUBSCRIPTION_ID, inserindo apenas a Subscription da sua conta;
9) Digite git init (inicializar o repositório Git dentro do diretório do seu projeto Terraform);
10) Digite git remote add origin https://github.com/seu-usuario/nome-do-repositorio.git
11) Digite git add . (para adicionar todos os arquivos to Terraform ao git);
12) Digite git -m commit "Primeiro Commit" (ou como preferir);
13) Digite git push -u origin main
14) No repositório Git → Actions → All Workflows, verifique se a pipeline está em execução e acompanhe os processos;
15) Após a pipeline ser executada com êxito, valide no Portal do Azure a criação dos recursos conforme descrito no arquivo yaml.
   

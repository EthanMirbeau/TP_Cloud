# TP Terraform - Déploiement d'une infrastructure Load-Balancée sur Azure

## 📋 Présentation du projet
Ce projet consiste à déployer une infrastructure complète avec une haute disponibilitée sur Azure en utilisant Terraform. L'objectif est de mettre en place deux serveurs web (Nginx) derrière un Load Balancer public pour distribuer le trafic de manière équitable.

**Étudiant :** Ethan MIRBEAU
**Formation :** Limayrac
**Outil :** Terraform >= 1.5.0, Azure CLI

---

## 🏗️ Architecture déployée
L'infrastructure comprend les ressources suivantes :
- **Resource Group** : Conteneur logique pour toutes les ressources.
- **VNET & Subnet** : Réseau virtuel 10.0.0.0/16 et sous-réseau 10.0.1.0/24.
- **Network Security Group (NSG)** : Firewall autorisant les ports 22 (SSH) et 80 (HTTP).
- **Load Balancer Standard** : Avec IP publique statique, Health Probe et Load Balancing Rule.
- **2 Machines Virtuelles Ubuntu** : Déployées avec `custom_data` pour l'installation automatique de Nginx.

---

## 🚀 Utilisation
1. **Initialisation** : `terraform init`
2. **Vérification** : `terraform plan`
3. **Déploiement** : `terraform apply -auto-approve`
4. **Destruction** : `terraform destroy -auto-approve`

---

## 📸 Preuves de réalisation (Livrables)

### 1. Terraform Plan

<img width="1903" height="620" alt="image" src="https://github.com/user-attachments/assets/71dbac96-39e2-421b-9b84-ca9d95489a66" />

### 2. Terraform Apply (Réussite)

<img width="1900" height="611" alt="image" src="https://github.com/user-attachments/assets/654d5b4e-7e7f-48e1-9cb8-e73cc5a7c7c6" />

### 3. Accès au serveur via Load Balancer (VM 0)

<img width="532" height="130" alt="image" src="https://github.com/user-attachments/assets/355f83a5-5326-4bee-a0b0-06ef919035d8" />

### 4. Accès au serveur via Load Balancer (VM 1)

<img width="516" height="185" alt="image" src="https://github.com/user-attachments/assets/af4bea9b-26a7-47dd-9a51-b62a10ab6221" />

### 5. Terraform Destroy

<img width="1051" height="73" alt="image" src="https://github.com/user-attachments/assets/fcf7b59f-679a-41ca-9d3b-5a6313867fd6" />
<img width="466" height="117" alt="image" src="https://github.com/user-attachments/assets/c09f8311-20d6-4192-a3f0-a9a64e62dfe9" />
<img width="472" height="103" alt="image" src="https://github.com/user-attachments/assets/b2e50c51-819a-4634-aeb5-707d755a23e0" />

---

## 🛠️ Structure du projet
- `versions.tf` : Contraintes de version de Terraform et du provider.
- `provider.tf` : Configuration du provider Azure.
- `variables.tf` : Définition des variables (prefix, location).
- `main.tf` : Définition de toutes les ressources d'infrastructure.
- `outputs.tf` : Export des informations clés (IP publique du LB).

  <img width="625" height="210" alt="image" src="https://github.com/user-attachments/assets/ab116fa7-d0d3-40d3-8600-f4539f3a20bc" />

---

## 🧠 Réflexions et Difficultés Rencontrées

### ❌ Difficulté 1 : Restrictions de l'abonnement Azure (Azure Policy)
**Problème :** Lors des premières tentatives en `westeurope` et `francecentral`, j'ai rencontré l'erreur `RequestDisallowedByAzure`. 
**Analyse :** L'abonnement "Azure for Students" de Limayrac restreint la création de ressources (surtout les VNets) à certaines régions spécifiques pour optimiser les quotas.
**Solution :** Après plusieurs tests de régions (`switzerlandnorth`, `eastus`), j'ai stabilisé l'infrastructure en m'assurant que la configuration réseau correspondait aux politiques autorisées.

### ⚠️ Difficulté 2 : Perte de session et fichiers vides
**Problème :** Une déconnexion du Cloud Shell a entraîné la perte des fichiers de configuration en cours.
**Solution :** J'ai restructuré le projet proprement en séparant les fichiers (`main.tf`, `variables.tf`, etc.). Cela a permis une meilleure lisibilité et a facilité le débogage.

### 🔍 Questions posées
- **Pourquoi utiliser un Load Balancer ?** Pour garantir que si une VM tombe en panne, le service reste disponible via la seconde.
- **Pourquoi le `custom_data` est-il en Base64 ?** Azure exige ce format pour injecter des scripts de post-installation (cloud-init) de manière sécurisée et lisible par le système.

---

variable "project_id" {
  description = "ID projektu GCP"
  type        = string
  # Ustaw przez TF_VAR_project_id lub w Cloud Build substitutions
}

variable "region" {
  description = "Region GCP"
  type        = string
  default     = "europe-central2"  # Warszawa
}

variable "cluster_name" {
  description = "Nazwa klastra GKE"
  type        = string
  default     = "gke-learning-cluster"
}

variable "worker_count" {
  description = "Liczba worker node'ów"
  type        = number
  default     = 2
}

variable "worker_machine_type" {
  description = "Typ maszyny dla node'ów (odpowiednik vm_size)"
  type        = string
  default     = "e2-medium"  # 2 vCPU, 4GB RAM - tanie do nauki
}

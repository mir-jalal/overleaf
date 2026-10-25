{{- define "overleaf.fullname" -}}
{{- if contains .Chart.Name .Release.Name -}}{{ .Release.Name | trunc 63 | trimSuffix "-" }}{{- else -}}{{ printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" }}{{- end -}}
{{- end -}}
{{- define "overleaf.labels" -}}
app.kubernetes.io/name: {{ .Chart.Name }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}
{{- define "overleaf.mongoUrl" -}}
{{- if .Values.mongodb.enabled -}}mongodb://{{ include "overleaf.fullname" . }}-mongodb:27017/sharelatex?replicaSet=overleaf{{- else -}}{{ required "mongodb.externalUrl is required when mongodb.enabled=false" .Values.mongodb.externalUrl }}{{- end -}}
{{- end -}}
{{- define "overleaf.redisHost" -}}
{{- if .Values.redis.enabled -}}{{ include "overleaf.fullname" . }}-redis{{- else -}}{{ required "redis.externalHost is required when redis.enabled=false" .Values.redis.externalHost }}{{- end -}}
{{- end -}}

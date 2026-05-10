# DevPod con container-dotfiles

## Cómo funciona

Al levantar un devpod con `--dotfiles https://github.com/usarral/container-dotfiles`, DevPod clona este repo dentro del contenedor y ejecuta `install.sh`. El script detecta el lenguaje activo via `DEVPOD_LANG` e instala herramientas, LSPs y plugins de Neovim automáticamente.

## Lenguajes soportados

| Valor `DEVPOD_LANG` | LSPs instalados | Extras |
|---------------------|-----------------|--------|
| `node`              | vtsls, eslint   | pnpm   |
| `java`              | jdtls           | mvnd   |
| `python`            | pyright, ruff   | pip upgrade |
| `go`                | gopls           | Go binary |
| `rust`              | rust_analyzer   | rustup |
| `php`               | intelephense    | —      |

Se pueden combinar: `DEVPOD_LANG=node,java`

---

## Añadir devpod a un proyecto real

### 1. Crear `.devcontainer/devcontainer.json`

**Node / TypeScript / NestJS**
```json
{
  "name": "mi-proyecto-node",
  "image": "node:22-bookworm",
  "containerEnv": {
    "DEVPOD_LANG": "node"
  }
}
```

**Python**
```json
{
  "name": "mi-proyecto-python",
  "image": "python:3.12-bookworm",
  "containerEnv": {
    "DEVPOD_LANG": "python"
  }
}
```

**Java (requiere Dockerfile para añadir git)**
```json
{
  "name": "mi-proyecto-java",
  "build": { "dockerfile": "Dockerfile" },
  "containerEnv": {
    "DEVPOD_LANG": "java"
  }
}
```
```dockerfile
# .devcontainer/Dockerfile
FROM eclipse-temurin:21-jdk-jammy
RUN apt-get update -q && apt-get install -y -q git && rm -rf /var/lib/apt/lists/*
```

> **Nota:** Las imágenes que no incluyen `git` requieren un Dockerfile que lo instale. DevPod necesita git dentro del contenedor para clonar los dotfiles.

### 2. Levantar el devpod

```bash
devpod up /ruta/a/tu-proyecto \
  --id nombre-workspace \
  --dotfiles https://github.com/usarral/container-dotfiles \
  --dotfiles-script install.sh \
  --provider ssh --ide none
```

Si el `DEVPOD_LANG` ya está en el `devcontainer.json` no hace falta `--dotfiles-script-env`.

Si querés sobreescribirlo puntualmente:
```bash
devpod up /ruta/proyecto --id nombre \
  --dotfiles https://github.com/usarral/container-dotfiles \
  --dotfiles-script install.sh \
  --dotfiles-script-env DEVPOD_LANG=node \
  --provider ssh --ide none
```

### 3. Conectarse

```bash
devpod ssh nombre-workspace
```

---

## Gestión de workspaces

```bash
# Listar
devpod list

# Parar
devpod stop nombre-workspace

# Borrar
devpod delete nombre-workspace --force

# Limpiar estado remoto (si devpod no puede borrarlo)
ssh usarral@10.0.0.253 "doas -n rm -rf ~/.devpod/agent/contexts/default/workspaces/nombre-workspace"
```

---

## Neovim — keymaps principales

### Navegación
| Atajo | Acción |
|-------|--------|
| `<Tab>` | Oil (explorador de archivos) |
| `<leader>f` | Buscar archivos |
| `<leader>g` | Live grep |
| `<leader>b` | Buffers |
| `<leader>e` | Harpoon menu |
| `<leader>a` | Harpoon add |

### LSP
| Atajo | Acción |
|-------|--------|
| `gd` | Ir a definición |
| `gr` | Referencias |
| `K` | Hover |
| `<leader>r` | Rename |
| `<leader>ca` | Code action |
| `<leader>fmt` | Formatear |
| `<leader>d` | Diagnóstico inline |

### Diagnósticos (Trouble)
| Atajo | Acción |
|-------|--------|
| `<leader>xx` | Todos los diagnósticos |
| `<leader>xX` | Diagnósticos del buffer |
| `<leader>xs` | Símbolos |
| `<leader>xl` | LSP referencias |

### Búsqueda (fzf-lua)
| Atajo | Acción |
|-------|--------|
| `<leader>?` | Keymaps |
| `<leader>P` | Comandos |
| `<leader>H` | Help tags |

### Otros
| Atajo | Acción |
|-------|--------|
| `<leader>tw` | Twilight (foco en código) |
| `<leader>fs` | Rip substitute |
| `<C-\>` | Terminal |
| `<C-s>` | Guardar |

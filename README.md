# Neovim config

Neovim >= 0.12, gestor de paquetes nativo `vim.pack` (sin lazy.nvim ni
packer). Un archivo por plugin en `lua/plugins/`: cada archivo se
documenta a si mismo, se instala a si mismo, se configura, y define sus
propios keybinds.

## Estructura

- `init.lua` — leader keys, carga `core/` y luego `plugins/`
- `lua/core/options.lua` — ajustes base (numeros, indentacion, busqueda, clipboard...)
- `lua/core/keymaps.lua` — keymaps de editor que no pertenecen a ningun plugin
- `lua/core/autocmds.lua` — autocomandos varios
- `lua/plugins/*.lua` — un plugin por archivo (ver el comentario al inicio de cada uno)

## Keybinds

Leader es `<space>`. Presiona `<leader>` y espera para ver el popup de
which-key con todo lo de abajo, agrupado.

| Teclas | Accion |
|---|---|
| `<leader><leader>` | Buscar archivos (Telescope, con fzf-native: "job model" encuentra `app/Models/Job.php` sin importar el orden; imagenes se previsualizan de verdad, no como texto) |
| `<leader>/` | Buscar texto / live grep (Telescope) |
| `<leader>fb` / `fh` / `fr` / `fd` / `fg` | Buffers / help / archivos recientes / diagnosticos / git status |
| `<leader>bb` | Listar buffers abiertos (Telescope) |
| `<leader>op` | Mostrar/ocultar explorador de archivos (neo-tree) |
| `<leader>gg` | Abrir Neogit (status: stage `s`, unstage `u`, commit `c`, ramas `b`) |
| `<leader>gs` / `gr` / `gp` / `gb` | Gitsigns: stage / reset / preview hunk / toggle line blame |
| `<leader>gB` | Gitsigns: vista completa de git blame (cerrar con `q` o `<Esc>`) |
| `]c` / `[c` | Siguiente / anterior hunk de git |
| `<leader>ca` / `rn` | LSP: code action / rename |
| `grn` `gra` `grr` `gri` `grt` `gO` `K` `]d` `[d` | Defaults nativos de LSP de Neovim 0.11+ (rename, code action, references, implementation, type definition, symbols, hover, diagnosticos) |
| `gd` | Ir a la definición (LSP, solo si el cliente lo soporta) |
| `gD` | Ver referencias/usos (LSP, alias de `grr`) |
| `<leader>bn` / `<leader>bp` | Buffer siguiente / anterior |
| `<leader>ll` / `la` / `lr` / `lm` / `lo` | Laravel: picker / artisan / rutas / make / recursos |
| `<C-g>` | Laravel: view finder |
| `gf` | Ir al recurso (Laravel-aware); si el cursor no esta sobre un recurso, cae al `gf` normal de Vim |

## Gestionar plugins (`vim.pack`)

- Agregar: agrega un spec al archivo correspondiente (o uno nuevo) y reinicia.
- Actualizar: `:lua vim.pack.update()` — abre un buffer de confirmacion tipo diff.
- Quitar: `:lua vim.pack.del({"nombre-del-plugin"})`.
- Inspeccionar: `:lua =vim.pack.get()`.

Ver `:h vim.pack` y `:h vim.pack-examples`.

## PHP / Laravel

- LSP: `intelephense` (instalado via Mason automaticamente en el primer arranque).
- Sintaxis Blade: `vim-blade`.
- Herramientas Laravel: `laravel.nvim` (artisan, rutas, make:*, view finder).
- Telescope ignora `vendor/`, `node_modules/`, `storage/`, `bootstrap/cache/`.
- Indentacion por defecto: 4 espacios (PSR-12). Si un repo trae
  `.editorconfig`, Neovim lo respeta de forma nativa sin necesidad de
  ningun plugin.

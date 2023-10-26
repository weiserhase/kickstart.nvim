local lspconfig = require 'lspconfig'
local util = require 'lspconfig'.util


-- find the parent src dir for a file if exists
local function find_src_dir(filename)
    return util.search_ancestors(filename, function(path)
        return util.path.exists(util.path.join(path, 'src')) and path or nil
    end)
end


-- Check for maven / gradle config
local function has_project_structure(filename)
    return util.root_pattern('pom.xml', 'build.gradle', '.git')(filename)
end
-- Setting up jdtls typechecking on single files/ non project files
lspconfig.jdtls.setup {
    cmd = { "jdtls" },
    root_dir = function(fname)
        return has_project_structure(fname)
            or find_src_dir(fname)
            or util.path.dirname(fname)
    end,
}

local tree = {}
tree.toggle = function()
    require'nvim-tree'.toggle()
    if require'nvim-tree.view'.is_visible() then
        local ntv = require'nvim-tree.view'
        require'bufferline.state'.set_offset(ntv.View.width+ 1, 'File Tree')
        require('nvim-tree').find_file(true)
    else
        require'bufferline.state'.set_offset(0)
    end
end

return tree

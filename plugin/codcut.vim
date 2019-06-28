let g:comment_message = "You can leave a comment on your snippet by writing something here. Leave it empty or as it is to leave no comments"
let g:codcut_url = 'https://resource.codcut.com/posts'

function! OpenCommentBuffer()
    let g:comment_file_name = tempname()

    call writefile([g:comment_message], g:comment_file_name)

    execute "split " . g:comment_file_name

    :aug CodcutCommentGroup
        au BufLeave <buffer> call SaveCommentBuffer(g:comment_file_name)
    :aug END
endfunction

function! SaveCommentBuffer(file_name)
    execute "bd " . a:file_name

    :aug CodcutCommentGroup
    :aug END

    let comment = trim(join(readfile(g:comment_file_name), "\n"))

    if comment ==# g:comment_message
        let comment = ""
    endif

    let extension = expand('%:e')

    if extension ==# ""
        let extension = &ft
    endif

    let json = webapi#json#encode({
        \ 'code': g:codcut_code,
        \ 'body': comment,
        \ 'language': extension
    \ })

    let response = webapi#http#post(g:codcut_url, json, { 'Authorization': 'Bearer ' . g:codcut_token })

    let response_json = webapi#json#decode(response['content'])

    echo response_json['id']
endfunction

function! g:VisualPostToCodcut()
    let old_a = @a

    silent normal! gv"ay
    let g:codcut_code = @a

    call OpenCommentBuffer()

    let @a = old_a
endfunction

command VisualPostToCodcut call g:VisualPostToCodcut()

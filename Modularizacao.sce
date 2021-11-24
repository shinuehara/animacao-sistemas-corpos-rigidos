//MODULARIZAÇÃO
diretorio = pwd()
exec(diretorio + '\transver.sci', -1);
exec(diretorio + '\genpat.sci', -1);
function resposta = gera_corpo(vertices_O, faces, translacao_O, rotacao, pontos_rastreados, funcao_rotacao, deslocamento_relativo)
    
    if ~exists("deslocamento_relativo","local") then
        deslocamento_relativo = zeros(translacao_O)
    end
    for i = 1:size(translacao_O)(1)
        Ri = funcao_rotacao(rotacao(i,1), rotacao(i,2), rotacao(i,3))
        ri = translacao_O(i,:)' + Ri * deslocamento_relativo(i,:)'
        vertices = transver(vertices_O, ri, Ri);
        resposta.patches(i) = genpat(vertices, faces);
    end
    if exists("pontos_rastreados","local") then
      for j = 1: length(pontos_rastreados)
          for i = 1:size(translacao_O)(1)
              if exists("deslocamento_relativo","local") then
                  ri = translacao_O(i,:)' + deslocamento_relativo(i,:)'
              else
                  ri = translacao_O(i,:)'
              end
              Ri = funcao_rotacao(rotacao(i,1), rotacao(i,2), rotacao(i,3))
              tragetoria_j = ri + Ri * [pontos_rastreados(j).x; pontos_rastreados(j).y; pontos_rastreados(j).z]
              ponto.x(i) = tragetoria_j(1)
              ponto.y(i) = tragetoria_j(2)
              ponto.z(i) = tragetoria_j(3)
          end
          resposta.pontos(j) = ponto
      end
    end
endfunction


function exibe_animacao(figura, lista_de_corpos, rotation_angles, data_bounds, filename)
    if exists("filename","local") then
        outgif = filename+'.gif';
        mdelete(outgif);
        idGif = animaGIF(gcf(), outgif, 10, 0);
    end
    for j = 1: length(lista_de_corpos(1,:))
        patch = lista_de_corpos(:,j)
        pat(j) = plot3d(patch.x(1), patch.y(1), patch.z(1))
        pat(j).color_mode = color_index;
        pat(j).foreground = 1;
        pat(j).hiddencolor = color_index;
        color_index = color_index + 2
    end
    
    xlabel("x"); ylabel("y"); zlabel("z");
    axes = gca();
    axes.isoview = "on";
    axes.box = "off";
    if exists("rotation_angles","local") then
        axes.rotation_angles = rotation_angles;
    end
    
    if exists("data_bounds","local") then
        axes.data_bounds = data_bounds;
    end
    xgrid;
    
    for i = 2:length(lista_de_corpos(:,1))
        drawlater();
        for j = 1: length(lista_de_corpos(1,:))
            patch = lista_de_corpos(:,j)
            pat(j).data.x = patch.x(i);
            pat(j).data.y = patch.y(i);
            pat(j).data.z = patch.z(i);
        end
        drawnow();
        if exists("filename","local") then
            idGif = animaGIF(gcf(), idGif);
        end
    end
    if exists("filename","local") then
        animaGIF(idGif);
    end
endfunction

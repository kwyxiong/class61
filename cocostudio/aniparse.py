# coding:utf8
import json
import os
import sys
reload(sys)

sys.setdefaultencoding( "utf-8" )
__author__ = 'damein'

def toLua(moudleName,image , aniData, collision,plists):
    # luaTable = '-- moudle ' + moudleName + '\r\n'
    # luaTable += moudleName + ' = { }\r\n'
    #
    # luaTable += '-- files = { '
    # totalLen = len(plists)
    # for index in range(0,totalLen):
    #     filess = plists[index]
    #     # print(file)
    #     luaTable += ('{\"' + filess[0] + '\"' + ',\"' + filess[1] + '\"}')
    #     if index != totalLen -1 :
    #         luaTable += ','
    # luaTable += '}\r\n'

    luaTable = ''
    # anidata
    for aniName in aniData:
        luaTable += '-- 动作\n'
        luaTable += (moudleName + '.' +aniName  + ' = { }\r\n')

        # textures
        luaTable += '-- 这是用到的图片名,用来做索引\n'
        luaTable += moudleName  + '.' +aniName + '.textures = { \"'
        totalLen = len(image)
        for index in range(0,len(image)):
            if index == totalLen - 1:
                luaTable += (image[index] + '\" }\r\n')
            else:
                luaTable += (image[index] + '\" ')

                if index != 0 and index != totalLen - 1 and (index % 6) == 0:
                    luaTable += '\r\n\t\t\t'
                luaTable += ',\"'

        # collision
        luaTable += '-- 碰撞矩形的坐标,对应着图片\n'
        luaTable += moudleName + '.' +aniName + '.collision = { '
        for index in range(0,len(image)):
            col = collision[image[index]]
            luaTable += '{'
            if len(col) != 0:
                v1 = col[0]
                v2 = col[1]
                v3 = col[2]
                v4 = col[3]
                #luaTable += '{ ' + str(v1[0]) + ' , ' + str(v1[1]) + ' } , { ' + str(v2[0]) + ' , ' + str(v2[1]) + ' }'
                luaTable += '{ ' + str(v1[0]) + ' , ' + str(v1[1]) + ' } , { ' + str(v2[0]) + ' , ' + str(v2[1]) + ' } , { ' + str(v3[0]) + ' , ' + str(v3[1]) + ' } , { ' + str(v4[0]) + ' , ' + str(v4[1]) + ' }'
            if index == totalLen - 1:
                luaTable += '} }\r\n'
            else:
                luaTable += '} ,'
            if index != 0 and index != totalLen - 1 and (index % 6) == 0:
                luaTable += '\r\n\t\t\t\t'


        for layerName in aniData[aniName]:
            if layerName == 'loop':
                loopPlay = aniData[aniName]['loop']
                luaTable += u'-- 是否循环播放 '+aniName+'\n'
                ssss = ( moudleName + '.' + aniName + '.loop = ' + ('-1' if loopPlay else '1') + '\r\n')
                luaTable += ssss
            else:
                layer = aniData[aniName][layerName]
                imgs = layer['imgs']
                delays = layer['delays']
                luaTable += (moudleName + '.' + aniName + '.' + layerName  + ' = { { ')
                # images map
                totalLen = len(imgs)
                for index in range(0,totalLen):
                    name = imgs[index]
                    luaTable += str(name)
                    if index == (totalLen - 1):
                        luaTable += ' }'
                    else:
                        luaTable += ' , '
                # delays
                totalLen = len(delays)
                luaTable += ',{ '
                for index in range(0,totalLen):
                    if index == (totalLen - 1):
                        value = delays[0]
                    else:
                        value = delays[index + 1] - delays[index]
                    luaTable += str(value)
                    if index == (totalLen - 1):
                        luaTable += ' }'
                    else:
                        luaTable += ' , '

                # collision

                luaTable += ' }\r\n'

    return luaTable
    # luaTable += '\r\nreturn ' + moudleName

    # print(luaTable)
    # f = file(moudleName + '.lua','w')
    # f.write(luaTable)
    # f.close()

def parse(filepath,moudlename):
    f = file(filepath)
    allStr = f.read()
    aniSrcData = json.loads(allStr)
    # print aniSrcData.keys()

    images = { }
    aniPlayer = { }
    collision = { }
    plists = { }

    pngfiles = aniSrcData['config_png_path']
    plistfiles = aniSrcData['config_file_path']

    for i in range(0,len(plistfiles)):
        plists[i] = {}
        plists[i][0] = plistfiles[i]
        plists[i][1] = pngfiles[i]

    # moudleName =  aniSrcData['animation_data'][0]['name']
    aniData = aniSrcData['animation_data'][0]

    tempTextures = { }
    for texture in aniSrcData['texture_data']:
        imgname = texture['name']
        index =  len(images)
        images[ len(images) ] = imgname
        tempTextures[imgname] = index

        collision[imgname] = {}
        if texture.has_key('contour_data'):
            vertexSrc = texture['contour_data'][0]['vertex']
            vetex1 = vertexSrc[0]
            vetex2 = vertexSrc[1]
            vetex3 = vertexSrc[2]
            vetex4 = vertexSrc[3]

            collision[imgname][0] = {}
            collision[imgname][1] = {}
            collision[imgname][2] = {}
            collision[imgname][3] = {}
            
            collision[imgname][0][0] = int(vetex1['x'])
            collision[imgname][0][1] = int(vetex1['y'])

            collision[imgname][1][0] = int(vetex2['x'])
            collision[imgname][1][1] = int(vetex2['y'])

            collision[imgname][2][0] = int(vetex3['x'])
            collision[imgname][2][1] = int(vetex3['y'])

            collision[imgname][3][0] = int(vetex4['x'])
            collision[imgname][3][1] = int(vetex4['y'])

            # vetex1 = vertexSrc[2]
            # vetex2 = vertexSrc[0]

            # collision[imgname][0] = {}
            # collision[imgname][1] = {}
            # collision[imgname][0][0] = int(vetex1['x'])
            # collision[imgname][0][1] = int(vetex1['y'])
            # collision[imgname][1][0] = int(vetex2['x'])
            # collision[imgname][1][1] = int(vetex2['y'])

    # 映射表
    maps = { }
    bone_data = aniSrcData['armature_data'][0]['bone_data']
    for action in bone_data:
        actionName = action['name']
        maps[actionName] = { }
        index = 0
        for display_data in action['display_data']:
            textureNameData = display_data['name']
            textureName,_ = textureNameData.split('.')
            maps[actionName][index] = { }
            maps[actionName][index] = tempTextures[textureName]
            # print(index,textureName,tempTextures[textureName])
            index = index + 1

    #         skin_data
    for movData in aniData['mov_data']:
        aniName = movData['name']
        loopPlay = movData['lp']
        aniPlayer[aniName] = { }
        aniPlayer[aniName]['loop'] = loopPlay

        for mov_bone_data in movData['mov_bone_data']:
            # mov_bone_data = movData['mov_bone_data'][0]
            imgs = { }
            delays = { }
            layerName = mov_bone_data['name']
            # print(aniName,'---',layerName)
            aniPlayer[aniName][layerName] = { }
            index = 0
            # 取数据
            for frameData in mov_bone_data['frame_data']:
                imgs[index] = maps[layerName][frameData['dI']]
                # print(aniName,'---',layerName,'------',frameData['dI'],'-----',imgs[index])
                delays[index] = frameData['fi']
                index = index + 1
            aniPlayer[aniName][layerName]['imgs'] = imgs
            aniPlayer[aniName][layerName]['delays'] = delays
    # print('action data',aniPlayer)
    return toLua(moudlename,images,aniPlayer,collision,plists)

def getDirectorys( dir ):
    temps = []
    if os.path.exists(dir):
        for name in os.listdir(dir):
            path = os.path.join(dir,name)
            # 如果不是文件，那就是目录了
            if not os.path.isfile( path ):
                temps.append(name)
    else:
        print(u"目录不存在，请检查 " + dir)
    return temps

def writeFile(filename,data):
    f = file(filename + '.lua','w')
    f.write(data)
    f.close()

def parseDirectory( dir):
    heros = getDirectorys(dir)
    for hero_name in heros:
        if hero_name == 'output':
            continue
        print(u'解析 ' + hero_name)
        hero_path = os.path.join(dir,hero_name)
        actions = getDirectorys( hero_path )
        # 角色模块数据
        aniData = '-- moudle(' + hero_name + ')\r\n'
        aniData +='local ' + hero_name + ' = { }\r\n'

        for action_name in actions:
            action_export_path = os.path.join(hero_path,action_name,action_name,'Export')
            # 得到Export下面全部的目录
            actionsExport = getDirectorys(action_export_path)
            # print(actionsExport)
            for action_export_name in actionsExport:
                action_path = os.path.join(action_export_path,action_export_name,action_export_name + '.ExportJson')
                if os.path.exists(action_path):
                    # print('Parse ',action_path)
                    aniData += parse(action_path,hero_name)
                else:
                    print(u"文件不存在，请检查 " + action_path)
        aniData += '\nreturn ' + hero_name
        writeFile('output/lua/' + hero_name,aniData)

if __name__ == "__main__":
    # path = os.path.split(sys.argv[0])
    path = os.getcwd()
    print(u'解析开始!')
    if not os.path.exists(path + '/output/lua'):
        os.makedirs(path + '/output/lua')

    heroDataLua = parseDirectory(path)
    print(u'解析结束!')

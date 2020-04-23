# ケンさんにオーダーするリストを作成する


import os
import re
import math

import argparse

class Fabric:
  # ECHO: "角材（長さ600mm, 一辺:40mm ）"
  rePillar = re.compile(r'ECHO: "角材（長さ(\d+)mm, 一辺:(\d+)mm ）"')

  # ECHO: "板（ 厚さ:18mm, ヨコ:864mm, タテ:500mm ）"
  reBoard = re.compile(r'^ECHO: \"板（ 厚さ:(\d+)mm, ヨコ:(\d+)mm, タテ:(\d+)mm ）\"$')

  # ECHO: "屋根（ 厚さ:18mm, ヨコ:1037mm, タテ:857mm ）"
  reRoof = re.compile(r'^ECHO: "屋根（ 厚さ:(\d+)mm, ヨコ:(\d+)mm, タテ:(\d+)mm ）"$')

  def __init__(self, name, regex):
    self.name = name
    self.regex = regex
    self.length = 0
    return None

  def regMatch(self, str):
    # print("regMatch :" + str)
    return self.regex.match(str)

  def toString(self):
    return 'this is the base class.'

  def print(self):
    print( self.toString() )

  def rounding(self):
    pass
  
  @classmethod
  def roundOut(self, num):
    if num % 10 > 0 :
      return int(num/10 + 1)*10
    return num

# 柱クラス
class Pillar(Fabric):
  def __init__(self, str, name='角材', regex=Fabric.rePillar):
    super().__init__(name, regex)
    match = self.regMatch(str)
    if match is None:
      print("No matches in :" + self.name)
      return None
    self.length = int(match.group(1))
    self.square = int(match.group(2))

  def toString(self):
    return "柱 長さ%d, 一辺%d" % (self.length, self.square)

  def rounding(self):
    self.length = Fabric.roundOut(self.length)
    self.square = Fabric.roundOut(self.square)

# 板クラス
class Board(Fabric):
  def __init__(self, str, name='板', regex=Fabric.reBoard):
    super().__init__(name, regex)
    match = self.regMatch(str)
    self.thickness = int(match.group(1))

    edge1 = int(match.group(2))
    edge2 = int(match.group(3))

    # widthに短辺、lengthに長辺が入る
    if edge1 > edge2:
      self.length = edge1
      self.width = edge2
    else:
      self.length = edge2
      self.width = edge1

  def toString(self):
    return "板 厚さ%d, 横幅%d, 縦幅:%d" % (self.thickness, self.width, self.length)

  def rounding(self):
    # 板の厚さはそのまま
    self.width = Fabric.roundOut(self.width)
    self.length = Fabric.roundOut(self.length)

# 屋根クラス
class Roof(Board):
  def __init__(self, str, name='屋根', regex=Fabric.reRoof):
    super().__init__(str, name, regex)

  def toString(self):
    return "屋根 横幅%d, 縦幅:%d" % (self.width, self.length)


# 文字列を入力してBoardかPillarを返すFactory
class FabFactory:
  @classmethod
  def judge(self, str):
    if re.compile('^ECHO: "板.+').search(str):
      return Board(str)
    elif re.compile('^ECHO: "角材.+').search(str):
      return Pillar(str)
    elif re.compile('^ECHO: "屋根.+').search(str):
      return Roof(str)
    return None



class Allocator:
  def __init__(self, maxLength):
    self.channels = []
    self.materials = []
    self.maxLength = maxLength

  def pushByArray(self, array):
    array.sort(reverse=True)
    for num in array:
      self.push(num)

  def push(self, material):
    self.materials.append(material)
    chunk = material.length
    if chunk <= 0:
      raise ValueError('illregular length.')
    if chunk > self.maxLength:
      raise ValueError('over maxLength.')

    for ch in self.channels:
      if sum(ch) + chunk <= self.maxLength:
        ch.append(chunk)
        return self.channels.count

    self.channels.append([chunk])
    return self.channels.count

  # def sort(self):
  #   self.channels.sort(reverse=True)

  def print(self):
    for index, ch in enumerate(self.channels):
      maped_num = map(str, ch)
      print("No.%d, %dmm, parts=[%s]" % (index + 1, sum(ch), ', '.join(maped_num)))

    print("total %d  materials.\n" % len(self.channels))

class BoardAllocator(Allocator):
  def __init__(self, maxLength):
    self.channels = []
    self.materials = []
    self.maxLength = maxLength
    self.boardWidth = 240
    self.boardThickness = 18

  def push(self, material):
    super().push(material)
    super().push(material)

  def print(self):
    for index, ch in enumerate(self.channels):
      maped_num = map(str, ch)
      print("No.%d, %dmm x %dmm x %dmm, parts=[%s]" % (index + 1, sum(ch), self.boardWidth, self.boardThickness, ', '.join(maped_num)) )

    print("total %d  materials.\n" % len(self.channels))


class RoofAllocator(Allocator):
  def print(self):
    for index, ch in enumerate(self.materials):
      print("No.%d, %s" % (index + 1, ch.toString()))

    print("total %d  materials.\n" % len(self.channels))




class Summarizer():
  def __init__(self, maxLength):
    self.channels = []
    self.materials = []
    self.maxLength = maxLength

    self.countupDic = {}

  def pushByArray(self, array):
    array.sort(reverse=True)
    for num in array:
      self.push(num)

  def push(self, material):
    chunk = material.length
    if chunk <= 0:
      raise ValueError('illregular length.')
    if chunk > self.maxLength:
      raise ValueError('over maxLength.')

    self.push_to_dic(chunk)

  def push_to_dic(self, chunk):
    if chunk in self.countupDic:
      self.countupDic[chunk] = self.countupDic[chunk] + 1
    else:
      self.countupDic[chunk] = 1

    return self.countupDic[chunk]

  def print(self):
    for key in self.countupDic.keys():
      print("%s mm x %d" % (key, self.countupDic[key]))

class PillarSummarizer(Summarizer):
  def __init__(self, maxLength):
    super().__init__(maxLength)
    self.pillarSide = 40

  def print(self):
    for key in self.countupDic.keys():
      print("%s mm x %d mm x %d mm : %d 本" % (key, self.pillarSide, self.pillarSide, self.countupDic[key]))

class BoardSummarizer(Summarizer):
  def __init__(self, maxLength):
    super().__init__(maxLength)
    self.boardWidth = 240
    self.boardThickness = 18

  def print(self):
    for key in self.countupDic.keys():
      print("%s mm x %d mm x %d mm : %d 枚" % (key, self.boardWidth, self.boardThickness, self.countupDic[key] * 2))

class RoofSummarizer(Summarizer):
  def __init__(self, maxLength):
    super().__init__(maxLength)

  def push(self, material):
    chunk = material.toString()
    self.push_to_dic(chunk)

  def print(self):
    for key in self.countupDic.keys():
      # print("%s mm x %d mm x %d mm : %d 枚" % (key, self.boardWidth, self.boardThickness, self.countupDic[key]))
      print("%s : %d 枚" % (key, self.countupDic[key]))


if __name__ == "__main__":
  parser = argparse.ArgumentParser()
  parser.add_argument("input", help="切り出し計画（Kiero - OpenSCADの出力）を指定して下さい")
  #parser.add_argument("output", help="出力先を指定して下さい")
  args = parser.parse_args()

  filename = args.input
  #output_filename = args.output

  factory = FabFactory()
  materials = []
  with open(filename, encoding='utf-8') as fh:
    for line in fh:
      line = line.rstrip(os.linesep)
      # print(line)
      fab = factory.judge(line)
      if fab is not None:
        fab.rounding()
        materials.append(fab)

  pillarAllocator = Allocator(2000)
  boardAllocator = BoardAllocator(2000)
  roofAllocator = RoofAllocator(1800)
  # pillarAllocator = PillarSummarizer(2000)
  # boardAllocator = BoardSummarizer(2000)
  # roofAllocator = RoofSummarizer(1800)

  materials.sort(key=lambda x:x.length, reverse=True)
  for fab in materials:
    # allocator.push(fab)
    if isinstance(fab, Pillar):
      pillarAllocator.push(fab)
    elif isinstance(fab, Roof):
      roofAllocator.push(fab)
    elif isinstance(fab, Board):
      boardAllocator.push(fab)
    else:
      print(fab)

  print('柱パーツ')
  pillarAllocator.print()

  print('板材パーツ')
  boardAllocator.print()

  print('屋根材ポリカ波板パーツ')
  roofAllocator.print()



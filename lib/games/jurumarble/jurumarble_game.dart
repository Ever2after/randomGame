import 'dart:collection';

class Game {
  static int test = 1;

  int playerNum = 0;
  List<int> playerPos;
  List<LinkedList<Player>> board; //linkedlist가 각 칸마다 20개 있는거 (node는 플레이어)

  Game(); //흠 머 해야하나

  void setPlayerNum(int playerNum) {
    this.playerNum = playerNum;
    playerPos = List(playerNum);
    board = List(20);
    for (int k = 0; k < 20; k++)
      board[k] = LinkedList();
    for (int k = 0; k < playerNum; k++)
    {
      playerPos[k] = 0;
      board[0].add(Player(k));
    }
  }


  double getPosX(double defaultPosX, int num, int idx, double len)
  {
    if (num == 1 || (num == 3 && idx == 2))
      return (defaultPosX + len / 3);
    else if (num <= 3 && idx == 1)
      return (defaultPosX);
    else if (num <= 3)
      return (defaultPosX + len / 3 * 2);
    else if (idx <= (num + 1) ~/ 2)
      return (getPosX(defaultPosX, (num + 1) ~/ 2, idx , len));
    else
      return (getPosX(defaultPosX, num ~/ 2 , idx - (num + 1) ~/ 2, len));
  }

  double getPlayerPosX(double width, double height, int curPlayer) {
    int num, idx;
    int i = 0;
    double defaultPosX;
    int pos = playerPos[curPlayer];
    board[pos].forEach((entry) {
      i++;
      if (entry.id == curPlayer)
        idx = i;
    });
    num = board[pos].length;
    if (pos < 6)
      defaultPosX = pos * width / 7;
    else if (pos < 10)
      defaultPosX = width / 7 * 6;
    else if (pos < 16)
      defaultPosX = width - (pos - 9) * (width / 7);
    else
      defaultPosX = 0;
    double ret = getPosX(defaultPosX, num, idx, width / 7);
    return ret;
  }

  double getPosY(double defaultPosY, int num, int idx, double len)
  {
    if (idx <= 3 && !(idx == 3 && num == 4))
      return (defaultPosY + len / 3 * 2);
    else
      return (defaultPosY);
  }

  double getPlayerPosY(double width, double height, int curPlayer) {
    int num, idx;
    int i = 0;
    double defaultPosY;
    int pos = playerPos[curPlayer];
    board[pos].forEach((entry) {
      i++;
      if (entry.id == curPlayer)
        idx = i;
    });
    num = board[pos].length;
    if (pos < 6)
      defaultPosY = height / 5 * 4;
    else if (pos < 10)
      defaultPosY = height - (pos - 5) * (height / 5);
    else if (pos < 16)
      defaultPosY = 0;
    else
      defaultPosY = height / 5 * (pos - 16);
    double ret = getPosY(defaultPosY, num, idx, height / 5);
    return ret;
  }

  bool endGame(int curPlayer) {
    return playerPos[curPlayer] == 19;
  }

  void movePlayer(int curPlayer) {
    int precPos = playerPos[curPlayer];
    Player player;
    board[precPos].forEach((entry) {
      if (entry.id == curPlayer)
        player = entry;
    });
    board[precPos].remove(player);
      if (precPos < 19)
        board[precPos + 1].add(player);
    playerPos[curPlayer] ++;
  }
}

class Player extends LinkedListEntry<Player> {
  final int id;
  Player(this.id);
}
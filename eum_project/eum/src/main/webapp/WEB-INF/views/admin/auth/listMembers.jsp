<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
  // 기대 모델: page(Page<MemberVO>), q(PageRequest)
%>

<div class="container">
  <h2>회원 목록</h2>

  <form method="get" action="${pageContext.request.contextPath}/admin/auth/listMembers.do" class="form-inline" style="margin-bottom:10px;">
    <select name="field">
      <option value="">전체</option>
      <option value="id"    ${q.field == 'id' ? 'selected' : ''}>ID</option>
      <option value="name"  ${q.field == 'name' ? 'selected' : ''}>이름</option>
      <option value="email" ${q.field == 'email' ? 'selected' : ''}>이메일</option>
    </select>
    <input type="text" name="keyword" value="${q.keyword}" placeholder="검색어"/>
    <select name="status">
      <option value="">상태 전체</option>
      <option value="ACTIVE"   ${q.status == 'ACTIVE' ? 'selected' : ''}>ACTIVE</option>
      <option value="INACTIVE" ${q.status == 'INACTIVE' ? 'selected' : ''}>INACTIVE</option>
    </select>
    <select name="sort">
      <option value="created_at" ${q.sort == 'created_at' ? 'selected' : ''}>가입일</option>
      <option value="last_login" ${q.sort == 'last_login' ? 'selected' : ''}>마지막 로그인</option>
      <option value="name"       ${q.sort == 'name' ? 'selected' : ''}>이름</option>
      <option value="email"      ${q.sort == 'email' ? 'selected' : ''}>이메일</option>
      <option value="points"     ${q.sort == 'points' ? 'selected' : ''}>포인트</option>
    </select>
    <select name="order">
      <option value="DESC" ${q.order != 'ASC' ? 'selected' : ''}>내림차순</option>
      <option value="ASC"  ${q.order == 'ASC' ? 'selected' : ''}>오름차순</option>
    </select>
    <input type="number" name="size" min="1" value="${page.size}" style="width:70px"/>
    <button type="submit">검색</button>
  </form>

  <table border="1" cellpadding="6" cellspacing="0" width="100%">
    <thead>
    <tr>
      <th>ID</th><th>이름</th><th>이메일</th><th>상태</th><th>포인트</th><th>가입일</th><th>마지막 로그인</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="m" items="${page.rows}">
      <tr>
        <td>${m.id}</td>
        <td>${m.name}</td>
        <td>${m.email}</td>
        <td>${m.status}</td>
        <td>${m.points}</td>
        <td>${m.createdAt}</td>
        <td>${m.lastLogin}</td>
      </tr>
    </c:forEach>
    <c:if test="${empty page.rows}">
      <tr><td colspan="7">데이터가 없습니다.</td></tr>
    </c:if>
    </tbody>
  </table>

  <div style="margin-top:10px;">
    <c:set var="totalPages" value="${page.totalPages}"/>
    <c:forEach begin="1" end="${totalPages}" var="p">
      <c:choose>
        <c:when test="${p == page.page}">
          <strong>[${p}]</strong>
        </c:when>
        <c:otherwise>
          <a href="?page=${p}&size=${page.size}&field=${q.field}&keyword=${q.keyword}&status=${q.status}&sort=${q.sort}&order=${q.order}">[${p}]</a>
        </c:otherwise>
      </c:choose>
    </c:forEach>
  </div>
</div>

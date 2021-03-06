<%--

    Licensed to Apereo under one or more contributor license
    agreements. See the NOTICE file distributed with this work
    for additional information regarding copyright ownership.
    Apereo licenses this file to you under the Apache License,
    Version 2.0 (the "License"); you may not use this file
    except in compliance with the License.  You may obtain a
    copy of the License at the following location:

      http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing,
    software distributed under the License is distributed on an
    "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
    KIND, either express or implied.  See the License for the
    specific language governing permissions and limitations
    under the License.

--%>
<%@ include file="/WEB-INF/jsp/include.jsp" %>
<%--
    Model Attributes:
        coursesByTerm   - CoursesByTerm
 --%>
<!-- Course List -->
        <c:choose>
            <c:when test="${ fn:length(coursesByTerm.courses) == 0 }">
                <p><spring:message code="no.courses.message"   htmlEscape="false" arguments="${portletSessionScope.helpDeskURL}"/></p>
            </c:when>
            <c:otherwise>
                <ul data-role="listview" class="course-list <c:if test="${! isMobile}">noMobile</c:if>">
                    <c:forEach items="${ coursesByTerm.courses }" var="course">
                    <portlet:renderURL var="courseUrl">
                        <portlet:param name="action" value="showCourse"/>
                        <portlet:param name="termCode" value="${ coursesByTerm.termCode }"/>
                        <portlet:param name="catalogNbr" value="${ course.code }"/>
                        <portlet:param name="subjectCode" value="${ course.courseDepartment.code }"/>
                         <portlet:param name="courseId" value="${course.id}"/>
                         <c:forEach items="${ course.courseAdditionalInfos}" var="addInfo">
                            <c:set var="addInfoKey" value="${addInfo.key}" />
                            <c:if test="${addInfoKey=='classNbr'}">
                                <c:set var="classNbr" value="${addInfo.value}" />
                            </c:if>
                        </c:forEach>
                        <portlet:param name="classNbr" value="${classNbr }"/>
                    </portlet:renderURL>
                       <li>
                            <a href="${ courseUrl }">
                                <c:if test="${! isMobile}">
                                  <span class="icon-mimic">&nbsp;</span>
                                </c:if>
                                <h3 class="title">${ course.courseDepartment.name }&nbsp;${ course.code }</h3>
                                <p>
                                    <span class="catalog">${ course.title }</span>
                                </p>
                                <c:set var="newCount" value="${ course.newUpdateCount }"/>
                                <c:if test="${ newCount > 0 }">
                                    <span class="ui-li-count badge">${ newCount }</span>
                                </c:if>
                            </a>
                        </li>
                    </c:forEach>
                </ul>
            </c:otherwise>
        </c:choose>
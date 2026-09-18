<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<style>
#logi-fab {
    position: fixed;
    right: 24px;
    bottom: 24px;
    width: 60px;
    height: 60px;
    border-radius: 50%;
    background: #2563eb;
    color: white;
    border: none;
    cursor: pointer;
    box-shadow: 0 4px 12px rgba(37, 99, 235, 0.4);
    z-index: 999;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 26px;
    transition: transform 0.2s;
}
#logi-fab:hover { transform: scale(1.08); }
#logi-fab-pulse {
    position: fixed;
    right: 24px;
    bottom: 24px;
    width: 60px;
    height: 60px;
    border-radius: 50%;
    background: #2563eb;
    opacity: 0.35;
    animation: logi-pulse 2s ease-out infinite;
    pointer-events: none;
    z-index: 998;
}
@keyframes logi-pulse {
    0% { transform: scale(1); opacity: 0.35; }
    100% { transform: scale(1.7); opacity: 0; }
}
#logi-drawer {
    position: fixed;
    right: 0;
    top: 0;
    bottom: 0;
    width: 400px;
    max-width: 100vw;
    background: #ffffff;
    border-left: 1px solid #e5e7eb;
    box-shadow: -4px 0 20px rgba(0, 0, 0, 0.1);
    transform: translateX(100%);
    transition: transform 0.35s cubic-bezier(0.2, 0.9, 0.3, 1);
    display: flex;
    flex-direction: column;
    z-index: 1000;
    font-family: 'Malgun Gothic', 'Segoe UI', sans-serif;
}
#logi-drawer.open { transform: translateX(0); }
.logi-header {
    padding: 16px 18px;
    border-bottom: 1px solid #f0f0f0;
    display: flex;
    align-items: center;
    justify-content: space-between;
    background: white;
}
.logi-title {
    display: flex;
    align-items: center;
    gap: 10px;
}
.logi-avatar {
    width: 36px;
    height: 36px;
    border-radius: 50%;
    background: #dbeafe;
    color: #1e40af;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 18px;
}
.logi-name { font-weight: 600; font-size: 15px; color: #111827; }
.logi-desc { font-size: 12px; color: #6b7280; }
.logi-close {
    background: transparent;
    border: none;
    cursor: pointer;
    color: #6b7280;
    font-size: 22px;
    padding: 4px 8px;
    border-radius: 6px;
}
.logi-close:hover { background: #f3f4f6; }
#logi-messages {
    flex: 1;
    padding: 16px;
    overflow-y: auto;
    display: flex;
    flex-direction: column;
    gap: 10px;
    background: #fafafa;
}
.logi-msg-context {
    background: #fef3c7;
    color: #92400e;
    padding: 6px 10px;
    border-radius: 6px;
    font-size: 11px;
    align-self: flex-start;
    max-width: 90%;
}
.logi-msg-logi, .logi-msg-user {
    padding: 10px 14px;
    border-radius: 14px;
    font-size: 14px;
    line-height: 1.55;
    max-width: 85%;
    white-space: pre-wrap;
    word-break: break-word;
}
.logi-msg-logi {
    background: white;
    color: #111827;
    align-self: flex-start;
    border-bottom-left-radius: 4px;
    border: 1px solid #e5e7eb;
}
.logi-msg-user {
    background: #2563eb;
    color: white;
    align-self: flex-end;
    border-bottom-right-radius: 4px;
}
.logi-tool-log {
    background: #fff7ed;
    border-left: 3px solid #f97316;
    padding: 8px 12px;
    border-radius: 6px;
    font-size: 11px;
    align-self: flex-start;
    max-width: 90%;
    font-family: 'Consolas', monospace;
    color: #7c2d12;
}
.logi-tool-name {
    color: #ea580c;
    font-weight: 600;
    margin-bottom: 2px;
}
.logi-loading {
    align-self: flex-start;
    color: #2563eb;
    font-style: italic;
    font-size: 13px;
    padding: 6px 10px;
}
#logi-input-area {
    padding: 12px 16px;
    border-top: 1px solid #f0f0f0;
    background: white;
    display: flex;
    gap: 8px;
}
#logi-input {
    flex: 1;
    padding: 10px 12px;
    border: 1px solid #d1d5db;
    border-radius: 8px;
    font-family: 'Malgun Gothic', 'Segoe UI', sans-serif;
    font-size: 14px;
    resize: none;
    min-height: 40px;
    max-height: 100px;
    outline: none;
}
#logi-input:focus { border-color: #2563eb; }
#logi-send {
    background: #2563eb;
    color: white;
    border: none;
    padding: 0 16px;
    border-radius: 8px;
    cursor: pointer;
    font-weight: 500;
    font-size: 14px;
}
#logi-send:disabled { background: #9ca3af; cursor: not-allowed; }
</style>

<div id="logi-fab-pulse"></div>
<button id="logi-fab" onclick="logiToggle()" aria-label="로지와 대화 열기">🤖</button>

<div id="logi-drawer">
    <div class="logi-header">
        <div class="logi-title">
            <div class="logi-avatar">🤖</div>
            <div>
                <div class="logi-name">로지</div>
                <div class="logi-desc">AI 코딩 튜터</div>
            </div>
        </div>
        <button class="logi-close" onclick="logiToggle()" aria-label="닫기">×</button>
    </div>
    <div id="logi-messages">
        <div class="logi-msg-logi">안녕, ${username != null ? username : '친구'}! 나는 로지야. 궁금한 게 있으면 언제든 물어봐! 😊</div>
    </div>
    <div id="logi-input-area">
        <textarea id="logi-input" placeholder="로지에게 물어보세요 (Enter로 전송)" rows="1"></textarea>
        <button id="logi-send" onclick="logiSend()">전송</button>
    </div>
</div>

<script>
const LOGI_API = 'http://localhost:5001/api/chat';
const LOGI_USER = '${username != null ? username : "세훈"}';
const LOGI_CONTEXT = {
    problem_id: '${problem != null ? problem.problemId : ""}',
    problem_title: '${problem != null ? problem.title : ""}',
    student_code: ''
};

const logiDrawer = document.getElementById('logi-drawer');
const logiFab = document.getElementById('logi-fab');
const logiPulse = document.getElementById('logi-fab-pulse');
const logiMessages = document.getElementById('logi-messages');
const logiInput = document.getElementById('logi-input');
const logiSendBtn = document.getElementById('logi-send');

let contextShown = false;

function logiToggle() {
    const isOpen = logiDrawer.classList.toggle('open');
    logiFab.style.display = isOpen ? 'none' : 'flex';
    logiPulse.style.display = isOpen ? 'none' : 'block';
    
    if (isOpen && !contextShown && LOGI_CONTEXT.problem_title) {
        const ctx = document.createElement('div');
        ctx.className = 'logi-msg-context';
        ctx.innerHTML = '📝 지금 풀고 있는 문제: <strong>' + LOGI_CONTEXT.problem_title + '</strong>';
        logiMessages.insertBefore(ctx, logiMessages.firstChild);
        contextShown = true;
    }
    if (isOpen) setTimeout(() => logiInput.focus(), 100);
}

logiInput.addEventListener('keydown', (e) => {
    if (e.key === 'Enter' && !e.shiftKey) {
        e.preventDefault();
        logiSend();
    }
});

function addMsg(text, who) {
    const div = document.createElement('div');
    div.className = who === 'user' ? 'logi-msg-user' : 'logi-msg-logi';
    div.textContent = text;
    logiMessages.appendChild(div);
    logiMessages.scrollTop = logiMessages.scrollHeight;
}

function addToolLog(log) {
    const div = document.createElement('div');
    div.className = 'logi-tool-log';
    div.innerHTML = '<div class="logi-tool-name">🔧 ' + log.tool + '</div>' +
        '<div>결과: ' + JSON.stringify(log.result).substring(0, 100) + '...</div>';
    logiMessages.appendChild(div);
    logiMessages.scrollTop = logiMessages.scrollHeight;
}

function addLoading() {
    const div = document.createElement('div');
    div.className = 'logi-loading';
    div.id = 'logi-loading-el';
    div.textContent = '로지가 생각 중...';
    logiMessages.appendChild(div);
    logiMessages.scrollTop = logiMessages.scrollHeight;
}

function removeLoading() {
    const el = document.getElementById('logi-loading-el');
    if (el) el.remove();
}

async function logiSend() {
    const message = logiInput.value.trim();
    if (!message) return;
    
    const codeEditor = document.getElementById('code-editor');
    if (codeEditor) {
        LOGI_CONTEXT.student_code = codeEditor.value;
    }
    
    addMsg(message, 'user');
    logiInput.value = '';
    logiSendBtn.disabled = true;
    addLoading();
    
    try {
        const res = await fetch(LOGI_API, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                user_id: LOGI_USER,
                message: message,
                context: LOGI_CONTEXT
            })
        });
        
        if (!res.ok) throw new Error('서버 응답 실패: ' + res.status);
        
        const data = await res.json();
        removeLoading();
        
        if (data.tool_logs && data.tool_logs.length > 0) {
            data.tool_logs.forEach(log => addToolLog(log));
        }
        addMsg(data.answer, 'logi');
    } catch (err) {
        removeLoading();
        addMsg('❌ 로지에게 연결할 수 없어요. Flask 서버(5001)가 실행 중인지 확인해주세요.', 'logi');
        console.error(err);
    } finally {
        logiSendBtn.disabled = false;
        logiInput.focus();
    }
}
</script>
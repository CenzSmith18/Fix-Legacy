function SendAlert(source, data)
    TriggerClientEvent('rheein_notify:sendAlert', source, data)
end

function SendAlert(source, id)
    TriggerClientEvent('rheein_notify:removeAlert', source, id)
end